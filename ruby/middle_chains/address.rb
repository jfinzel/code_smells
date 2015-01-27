class Address

  attr_reader :house
  attr_reader :street
  attr_reader :city
  attr_reader :state
  attr_reader :zipcode

  def initialize(house, street, city, state, zipcode)
    @house = house
    @street = street
    @city = city
    @state = state
    @zipcode = zipcode
  end
end
