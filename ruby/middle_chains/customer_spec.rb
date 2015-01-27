require "minitest"
require "minitest/autorun"
require "minitest/pride"
require 'pry'

require "./customer"
require "./address"
describe Customer do
  let(:full_name){Faker::Name.name}
  let(:bday){Faker::Date.backward(300)}
  let(:number){Faker::Address.building_number}
  let(:street){Faker::Address.street_name}
  let(:city){Faker::Address.city}
  let(:state){Faker::Address.state_abbr}
  let(:zip){Faker::Address.zip}
  before do 
    @customer = Customer.new(full_name, bday, Address.new(number, street, city, state, zip))
    @movie_store = MovieStore.new('Blockbuster', Address.new(number, street, city, state, zip))
    6.times do
      @customer.add_rental(Movie.new('Pulp Fiction', Rating::R, @movie_store ))
    end
  end

  describe ".summary" do
    it "includes full name and address" do
      @customer.summary.must_equal "#{full_name}, #{number} #{street}, #{city}, #{state} #{zip}"
    end
  end

  describe '.favorite_movie_city' do
    before do
      5.times do 
        store = MovieStore.new('Blockbuster', Address.new(number, street, Faker::Address.city, state, zip))
        @customer.add_rental(Movie.new('Pulp Fiction', Rating::R, store ))
      end
    end
    it 'finds favorite movie city' do
      @customer.favorite_movie_city.must_equal city
    end
  end

end

