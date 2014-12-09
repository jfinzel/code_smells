require "minitest"
require "minitest/autorun"
require "minitest/pride"
require "./movie"
require "./rating"

describe Movie do
  describe 'Rental Ages' do
    it 'knows minimum age for G rated movies' do
      movie = Movie.new('Cars', Rating::G)
      movie.min_age_to_rent.must_equal 0
    end

    it 'knows minimum age for PG rated movies' do
      movie = Movie.new('Secondhand Lions', Rating::PG)
      movie.min_age_to_rent.must_equal 0
    end

    it 'knows minimum age for PG13 rated movies' do
      movie = Movie.new("Spider-Man", Rating::PG13)
      movie.min_age_to_rent.must_equal 13
    end

    it 'knows minimum age for R rated movies' do
      movie = Movie.new("Braveheart", Rating::R)
      movie.min_age_to_rent.must_equal 17
    end
    it 'knows minimum age for NC17 rated movies' do
      movie = Movie.new("XXX",  Rating::NC17)
      movie.min_age_to_rent.must_equal 18
    end
  end
end
