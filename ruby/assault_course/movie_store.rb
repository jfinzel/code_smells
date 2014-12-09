class MovieStore

  attr_reader :address
  attr_reader :name

  def initialize(name, address)
    @name = name
    @movies = {}
  end

  def has_movie?(title)
    @movies.has_key?(title)
  end

  def rent_to(customer, movie)
    raise CustomerUnderageException.new if customer_too_young?(customer, movie)
    customer.add_rental(movie)
    @movies.delete(movie.title)
  end

  def add_movie(movie)
    @movies[movie.title] = movie
  end

  private
  def customer_too_young?(customer, movie)
    begin
      today = Date.today
      age = age_in_years(customer, today)
      age < movie.min_age_to_rent

    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
      return true
    end
  end

  def age_in_years(customer, today)
    date_of_birth = Date.strptime(customer.date_of_birth, "%Y-%m-%d")
    age_year = today.year - date_of_birth.year
    age_month = today.month - date_of_birth.month
    age_year - negative_month_difference(age_month)
  end

  def negative_month_difference(months)
    months < 0 ? 1 : 0
  end
end
