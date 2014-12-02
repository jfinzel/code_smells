require "minitest"
require "minitest/autorun"
require "minitest/pride"
require "faker"
require "./movie"
require "./customer"

describe Movie do
  describe 'Rental Ages' do
    let(:full_name){Faker::Name.name}
    let(:number){Faker::Address.building_number}
    let(:street){Faker::Address.street_name}
    let(:city){Faker::Address.city}
    let(:state){Faker::Address.state_abbr}
    let(:zip){Faker::Address.zip}
    it 'denies rental of R-rated movies to kids' do
      customer = Customer.new(full_name, "2008-01-01", number, street, city, state, zip)
      movie = Movie.new("Braveheart", 'R')
      assert_raises CustomerUnderageException do
        movie.rent_for(customer)
      end
    end

    it 'denies rental of NC-17 movies to people under 18' do
      customer = Customer.new(full_name, "1997-01-01", number, street, city, state, zip)
      movie = Movie.new("XXX", 'NC17')
      assert_raises CustomerUnderageException do
        movie.rent_for(customer)
      end
    end

    it 'allows legal movie renting' do
      customer = Customer.new(full_name, "1980-01-01", number, street, city, state, zip)
      movie = Movie.new("Spider-Man", 'PG13')
      movie.rent_for(customer)
      customer.rentals.must_include movie
    end

    it 'allows anyone to rent G-rated movies' do
      customer = Customer.new(full_name, "2014-01-01", number, street, city, state, zip)
      movie = Movie.new("The Lion King", 'G')
      movie.rent_for(customer)
      customer.rentals.must_include movie
    end
  end
end
