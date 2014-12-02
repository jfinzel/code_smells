class MovieStore

  attr_reader :building_number
  attr_reader :street
  attr_reader :city
  attr_reader :state
  attr_reader :zipcode
  attr_reader :name

  def initialize(name)
    @movies = {}
    @name = name
  end

  def has_movie?(title)
    @movies.has_key? title
  end

  def add_movie(movie)
    @movies[movie.title] = movie
  end
end
