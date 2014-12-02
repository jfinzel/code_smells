class Customer
  attr_reader :date_of_birth
  attr_reader :rentals
  attr_reader :building_number
  attr_reader :street
  attr_reader :city
  attr_reader :state
  attr_reader :zipcode

  def initialize(name, date_of_birth, house, street, city, state, zipcode)

    @name = name
    @date_of_birth = date_of_birth
    @rentals = []
    @house = house
    @street = street
    @city = city
    @state = state
    @zipcode = zipcode

  end

  def add_rental(movie)
    @rentals << movie
  end

  def summary
    "#{@name}, #{@house} #{@street}, #{@city}, #{@state} #{@zipcode}"
  end


end
