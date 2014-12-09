require 'pry'
require './rating'
class Customer
  attr_reader :name
  attr_reader :date_of_birth
  attr_reader :rentals
  attr_reader :address

  def initialize(name, date_of_birth, address)
    @name = name
    @date_of_birth = date_of_birth
    @rentals = []
    @address = address
  end

  def add_rental(movie)
    @rentals << movie
  end

  def summary
    "#{@name}, #{@address.house} #{@address.street}, #{@address.city}, #{@address.state} #{@address.zipcode}"
  end

  def statement
    total_amount, frequent_renter_points = 0, 0
    result = "Rental Record for #{@name}\n"
    @rentals.each do |element|
      this_amount = 0
      case element.rating
      when Rating::G
        this_amount += 2
      when Rating::PG
        this_amount += 3
      when Rating::PG13
        this_amount += 3.5
      when Rating::R
        this_amount += 1
      end

      #add frequent renter points
      frequent_renter_points += element.frequent_renter_points

      #show figures for this rental
      result += '\t' + element.title + '\t' + element.charge.to_s + '\n'
      total_amount += element.charge
    end
    #add footer lines 
    result += "Amount owed is #{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result
  end

  def html_statement
    total_amount, frequent_renter_points = 0, 0
    result = "<h2>Rental Record for #{@name}</h2>"
    result += "<table>"
    @rentals.each do |element|
      this_amount = 0
      case element.rating
      when Rating::G
        this_amount += 2
      when Rating::PG
        this_amount += 3
      when Rating::PG13
        this_amount += 3.5
      when Rating::R
        this_amount += 1
      end

      #add frequent renter points
      frequent_renter_points += element.frequent_renter_points

      #show figures for this rental
      result += '<tr><td>' + element.title + '</td><td>' + element.charge.to_s + '</td></tr>'
      total_amount += element.charge
    end
    result += '</table>'
    #add footer lines 
    result += "<h3>Amount owed is #{total_amount}</h3>"
    result += "<h4>You earned #{frequent_renter_points} frequent renter points</h4>"
    result
  end

  private
  def age_in_years
      today = Date.today
      date_of_birth = Date.strptime(@date_of_birth, "%Y-%m-%d")

      age_year = today.year - date_of_birth.year
      age_month = today.month - date_of_birth.month

      age_year -= negative_month_difference(age_month)
  end

  def negative_month_difference(months)
    months < 0 ? 1 : 0
  end
end
