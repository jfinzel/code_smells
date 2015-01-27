require "minitest"
require "minitest/autorun"
require "minitest/pride"
require "./movie"
require "./rating"

describe Movie do
  let(:full_name){Faker::Name.name}
  let(:bday){Faker::Date.backward(300)}
  let(:number){Faker::Address.building_number}
  let(:street){Faker::Address.street_name}
  let(:city){Faker::Address.city}
  let(:state){Faker::Address.state_abbr}
  let(:zip){Faker::Address.zip}
  before do
    @movie_store = MovieStore.new('Blockbuster', Address.new(number, street, city, state, zip))
  end
  describe 'Rental Ages' do
    it 'knows minimum age for G rated movies' do
      movie = Movie.new('Cars', Rating::G, @movie_store)
      movie.min_age_to_rent.must_equal 0
    end

    it 'knows minimum age for PG rated movies' do
      movie = Movie.new('Secondhand Lions', Rating::PG, @momovie_store)
      movie.min_age_to_rent.must_equal 0
    end

    it 'knows minimum age for PG13 rated movies' do
      movie = Movie.new("Spider-Man", Rating::PG13, @momovie_store)
      movie.min_age_to_rent.must_equal 13
    end

    it 'knows minimum age for R rated movies' do
      movie = Movie.new("Braveheart", Rating::R, @momovie_store)
      movie.min_age_to_rent.must_equal 17
    end
    it 'knows minimum age for NC17 rated movies' do
      movie = Movie.new("XXX",  Rating::NC17, @momovie_store)
      movie.min_age_to_rent.must_equal 18
    end
  end
end
