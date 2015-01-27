class Customer
  attr_reader :name
  attr_reader :date_of_birth
  attr_reader :rentals
  attr_reader :phone_number
  attr_reader :address

  def initialize(name, date_of_birth, address, phone_number = nil)
    @name = name
    @date_of_birth = date_of_birth
    @rentals = []
    @address = address
    @phone_number = nil
  end

  def add_rental(movie)
    @rentals << movie
  end

  def summary
    "#{@name}, #{@address.house} #{@address.street}, #{@address.city}, #{@address.state} #{@address.zipcode}"
  end

  def favorite_movie_city
    visited_cities = {}
    @rentals.each do |movie|
      if visited_cities[movie.city]
        visited_cities[movie.city] += 1
      else
        visited_cities[movie.city] = 1
      end
    end
    visited_cities.max_by{|city, visit_count| visit_count}.first
  end

  def too_young_for?(movie)
    begin
      today = Date.today
      age = age_in_years(today)
      age < movie.min_age_to_rent

    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
      return true
    end
  end

  def age_in_years(today = Date.today)
    date_of_birth = Date.strptime(self.date_of_birth, "%Y-%m-%d")
    age_year = today.year - date_of_birth.year
    age_month = today.month - date_of_birth.month
    age_year - negative_month_difference(age_month)
  end

  private
  def negative_month_difference(months)
    months < 0 ? 1 : 0
  end
end
