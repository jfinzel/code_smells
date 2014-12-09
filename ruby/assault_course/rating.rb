class Rating
  G = :G
  PG = :PG
  PG13 = :PG13
  R = :R
  NC17 = :NC17

  def self.minimum_age_for(rating)
    age_mapping = {:G => 0, :PG => 0, :PG13 => 13, :R => 17, :NC17 => 18}
    age_mapping[rating]
  end
end

