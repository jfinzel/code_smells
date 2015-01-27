class MovieStore

  attr_reader :address, :name

  def initialize(name, address)
    @name = name
    @address = address
    @movies = {}
  end

  def has_movie?(title)
    @movies.has_key?(title)
  end

  def rent_to(customer, movies)
    Array(movies).each do |movie|
      raise CustomerUnderageException.new if customer.too_young_for?(movie)
      customer.add_rental(movie)
      @movies.delete(movie.title)
    end
    receipt(customer, movies)
  end

  def add_movie(movie)
    @movies[movie.title] = movie
  end

  def receipt(customer, movies)
    total_amount, frequent_renter_points = 0, 0
    result = "Rental Record for #{customer.name}\n"
    result += "#{customer.house} #{customer.street}, #{customer.city}, #{customer.state} #{customer.zipcode},\n"
    result += "#{customer.phone_number}\n"
    Array(movies).each do |movie|
      this_amount = 0
      case movie.rating
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
      frequent_renter_points += movie.frequent_renter_points

      #show figures for this rental
      result += '\t' + movie.title + '\t' + movie.charge.to_s + '\n'
      total_amount += movie.charge
    end
    #add footer lines 
    result += "Amount owed is #{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result
  end
end
