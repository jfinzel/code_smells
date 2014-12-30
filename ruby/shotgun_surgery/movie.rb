require "date"
class Movie


  attr_reader :title, :rating

  def initialize(title, rating)
    @title = title
    @rating = rating
  end

  def frequent_renter_points
    @rating == :G ? 2 : 1
  end

  def min_age_to_rent
    Rating.minimum_age_for(@rating)
  end

  def charge
    (title[2].ord / 120.0 * rating.to_s[0].ord).round(2)
  end

  def to_s
    @title
  end


end

class CustomerUnderageException < Exception

end
