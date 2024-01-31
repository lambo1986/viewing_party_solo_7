require "rails_helper"

RSpec.describe MovieService, vcr: true do# applies vcr to all tests in this file
  describe ".top_rated" do
    it "returns the top rated movies" do
      movies = MovieService.top_rated

      expect(movies.count).to eq(20)
      expect(movies.first[:title]).to be_a String
      expect(movies.first[:vote_average]).to be_a Float
      expect(movies.first[:vote_count]).to be_a Integer
    end
  end

  describe ".search" do
    it "returns the movie by title entered" do
      movie = MovieService.search("Big")

      expect(movie[:title]).to be_a String
      expect(movie[:vote_average]).to be_a Float
      expect(movie[:vote_count]).to be_a Integer
    end
  end

  describe ".search_by_id" do
    it "returns the movie by id entered" do
      movie = MovieService.search_by_id(2280)#big

      expect(movie[:title]).to be_a String
      expect(movie[:vote_average]).to be_a Float
      expect(movie[:vote_count]).to be_a Integer
    end
  end

  describe ".genres_all" do# US-3
    it "returns the list of genres" do
      genres = MovieService.genres_all

      expect(genres.count).to eq(19)
      expect(genres.first[:name]).to be_a String
    end
  end

  describe ".genres_of_movie" do# US-3
    it "returns the list of genres for a movie" do
      genres = MovieService.genres_of_movie(2280)#big

      expect(genres.count).to eq(5)
      expect(genres.first).to be_a String
    end
  end

  describe ".runtime" do# US-3
    it "returns the runtime for a movie" do
      runtime = MovieService.runtime(2280)#big

      expect(runtime).to be_a String
    end
  end

  describe ".cast" do# US-3
    it "returns 10 members of the cast for a movie" do
      cast = MovieService.cast(2280)#big

      expect(cast.count).to eq(10)
      expect(cast.first[:name]).to be_a String
      expect([true, false]).to include(cast.first[:adult])# kool
      expect(cast.first[:character]).to be_a String
      expect(cast.first[:popularity]).to be_a Float
    end
  end

  describe ".reviews" do# US-3
    it "returns the reviews for a movie" do
      reviews = MovieService.reviews(2280)#big

      expect(reviews.count).to be_a Integer
      expect(reviews[:results].first[:author]).to be_a String
      expect(reviews[:total_results]).to be_an Integer
    end
  end
end
