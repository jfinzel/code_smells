require "minitest"
require "minitest/autorun"
require "minitest/pride"

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
  end

  describe ".summary" do
    it "includes full name and address" do
      @customer.summary.must_equal "#{full_name}, #{number} #{street}, #{city}, #{state} #{zip}"
    end
  end

  describe '.statement' do
    it 'prints correctly' do
      ['Cars', 'Lion King', 'Wreck It Ralph'].each do |title|
        @customer.add_rental(Movie.new(title, Rating::G))
      end
      expected = "Rental Record for #{full_name}\n\\tCars\\t67.45\\n\\tLion King\\t65.68\\n\\tWreck It Ralph\\t59.76\\nAmount owed is 192.89\nYou earned 6 frequent renter points"
      @customer.statement.must_equal expected
    end
  end

  describe '.html_statement' do
    it 'prints correctly' do
      ['Cars', 'Lion King', 'Wreck It Ralph'].each do |title|
        @customer.add_rental(Movie.new(title, Rating::G))
      end
      expected = "<h2>Rental Record for #{full_name}</h2><table><tr><td>Cars</td><td>67.45</td></tr><tr><td>Lion King</td><td>65.68</td></tr><tr><td>Wreck It Ralph</td><td>59.76</td></tr></table><h3>Amount owed is 192.89</h3><h4>You earned 6 frequent renter points</h4>"
      @customer.html_statement.must_equal expected
    end
  end

end
