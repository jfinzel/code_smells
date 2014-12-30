class MovieStore
  attr_reader :address
  attr_reader :name
  attr_reader :movies

  def initialize(name, address, movies = {})
    @name = name
    @address = address
    @movies = movies
  end

  def has_movie?(title)
    @movies.has_key?(title)
  end

  def rent_to(customer, movies)
    movies.each do |movie, cost|
      raise CustomerUnderageException.new if customer_too_young?(customer, movie)
      customer.pay(cost)
      customer.add_rental(movie)
      @movies.delete(movie.title)
    end
    print_receipt(movies)
  end

  def add_movies(movies)
    @movies[movie.title] = movie
  end

  def print_receipt(movies)
    receipt_string = "#{@name}\n"
    receipt_string += "#{@address}\n"
    total = movies.inject(0) do |total_cost, (title, cost)|
      receipt_string += "#{title} \t\t #{cost}\n"
      total_cost += cost
    end
    receipt_string += "--------------------------\nTotal Cost: #{total}"
  end

  private
  def customer_too_young?(customer, movie)
    begin
      customer.age_in_years < movie.min_age_to_rent
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
      return true
    end
  end

end
