require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'faker'

Dir["./*.rb"].each {|file| require file }

#before - returns a string
#after - can write to a file

number = Faker::Address.building_number
street = Faker::Address.street_name
city = Faker::Address.city
state = Faker::Address.state_abbr
zip = Faker::Address.zip
@address = Address.new(number, street, city, state, zip)

describe HardwareStore do

  before do
    @inventory = {'hammer' => 3.54, 'nails' => 4.21}
    @store = HardwareStore.new('Ace Hardware', @address, @inventory)
  end

  describe '.print_recipt' do
    let(:receipt){@store.print_receipt(@inventory)}
    it 'contains all items and costs' do
      @inventory.each do |name, cost|
        receipt.must_include(name)
        receipt.must_include(cost.to_s)
      end
    end
    it 'contains address' do
      receipt.must_include(@address.to_s)
    end

    it 'can be written to a file' do
      fail
    end

  end

end

describe GroceryStore do

  before do
    @stock = {'lard' => 3.90, 'bacon' => 7.28}
    @store = GroceryStore.new('Whole Foods', @address, @stock)
  end

  describe '.print_recipt' do
    let(:receipt){@store.print_receipt(@stock)}
    it 'contains all items and costs' do
      @stock.each do |name, cost|
        receipt.must_include(name)
        receipt.must_include(cost.to_s)
      end
    end
    it 'contains address' do
      receipt.must_include(@address.to_s)
    end

    it 'can be written to a file' do
      fail
    end

  end
end

describe MovieStore do

  before do
    @movies = ['Lion King', 'Cars', 'Little Mermaid'].inject( {} ) do |movies, title|
      movie = Movie.new(title, :G)
      movies[movie] = 3.24
      movies
    end
    @store = MovieStore.new('Blockbuster', @address, @movies)
  end

  describe '.print_recipt' do

    let(:receipt){@store.print_receipt(@movies)}
    it 'contains all items and costs' do
      @movies.each do |name, cost|
        receipt.must_include(name.to_s)
        receipt.must_include(cost.to_s)
      end
    end
    it 'contains address' do
      receipt.must_include(@address.to_s)
    end

    it 'can be written to a file' do 
      fail
    end
  end
end
