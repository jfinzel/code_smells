require "minitest"
require "minitest/autorun"
require "minitest/pride"
require "faker"
require 'active_support/core_ext'

require "./movie_store"
require "./movie"

describe MovieStore do
  before do
    @store = MovieStore.new("Blockbuster", Address.new(number, street, city, state, zip))
  end
  let(:full_name){Faker::Name.name}
  let(:bday){Faker::Date.backward(300)}
  let(:number){Faker::Address.building_number}
  let(:street){Faker::Address.street_name}
  let(:city){Faker::Address.city}
  let(:state){Faker::Address.state_abbr}
  let(:zip){Faker::Address.zip}

  it 'allows rental of available movies' do
    movie = Movie.new("Jaws", Rating::PG13, @store)
    @store.add_movie(movie)

    @store.has_movie?("Jaws").must_equal true
  end

  it 'doesnt rent movies it doesnt have' do
    @store.has_movie?("The Goonies").must_equal false
  end


  it "knows when it doesn't have a movie" do
    @store.has_movie?("The Goonies").must_equal false
  end

  it "removes movies from inventory" do
    movie = Movie.new("Jaws", Rating::PG13, @store)
    @store.add_movie(movie)
    customer = Customer.new(full_name, '2001-01-01', Address.new(number, street, city, state, zip))
    @store.rent_to(customer, movie)
    @store.has_movie?('Jaws').must_equal false
  end

  it 'denies rental of R-rated movies to kids' do
    age = (Date.today - 16.years).strftime("%Y-%m-%d")
    customer = Customer.new(full_name, age, Address.new(number, street, city, state, zip))
    movie = Movie.new("Braveheart", Rating::R, @store)
    assert_raises CustomerUnderageException do
      @store.rent_to(customer, movie)
    end
  end

  it 'denies rental of NC-17 movies to people under 18' do
    age = (Date.today - 17.years).strftime("%Y-%m-%d")
    customer = Customer.new(full_name, age, Address.new(number, street, city, state, zip))
    movie = Movie.new("XXX",  Rating::NC17, @store)
    assert_raises CustomerUnderageException do
      @store.rent_to(customer, movie)
    end
  end

  it 'allows legal movie renting' do
    customer = Customer.new(full_name, "1980-01-01", Address.new(number, street, city, state, zip))
    movie = Movie.new("Spider-Man", Rating::PG13, @store)
    @store.rent_to(customer, movie)
    customer.rentals.must_include movie
  end

  it 'allows anyone to rent G-rated movies' do
    customer = Customer.new(full_name, "2014-01-01", Address.new(number, street, city, state, zip))
    movie = Movie.new("The Lion King", Rating::G, @store)
    @store.rent_to(customer, movie)
    customer.rentals.must_include movie
  end

  it 'creates receipt' do
    customer = Customer.new(full_name, "1980-01-01", Address.new(number, street, city, state, zip))
    movies = ['Cars', 'Lion King', 'Wreck It Ralph'].inject( [] ) do |movies, title|
     movies << Movie.new(title, Rating::G, @store )
    end
    expected = "Rental Record for #{full_name}\n#{number} #{street}, #{city}, #{state} #{zip},\n\n\\tCars\\t67.45\\n\\tLion King\\t65.68\\n\\tWreck It Ralph\\t59.76\\nAmount owed is 192.89\nYou earned 6 frequent renter points"
    @store.receipt(customer, movies).must_equal expected
  end

end
