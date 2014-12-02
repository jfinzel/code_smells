require "minitest"
require "minitest/autorun"
require "minitest/pride"

require "./customer"
describe Customer do
  let(:full_name){Faker::Name.name}
  let(:bday){Faker::Date.backward(300)}
  let(:number){Faker::Address.building_number}
  let(:street){Faker::Address.street_name}
  let(:city){Faker::Address.city}
  let(:state){Faker::Address.state_abbr}
  let(:zip){Faker::Address.zip}
  describe ".summary" do
    it "includes full name and address" do
      customer = Customer.new(full_name, bday, number, street, city, state, zip)
      customer.summary.must_equal "#{full_name}, #{number} #{street}, #{city}, #{state} #{zip}"
    end
  end
end
