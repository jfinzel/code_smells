require "date"
class Movie

  attr_reader :title, :rating, :origin

  def initialize(title, rating, origin)
    @title = title
    @rating = rating
    @origin = origin
  end

  def frequent_renter_points
    @rating == :G ? 2 : 1
  end

  def min_age_to_rent
    Rating.minimum_age_for(@rating)
  end

  def charge
    (title[2].ord / 120.0 * rating.to_s.ord).round(2)
  end


end

class CustomerUnderageException < Exception

end
