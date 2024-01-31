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
      movie = MovieService.search_by_id(2280)

      expect(movie[:title]).to be_a String
      expect(movie[:vote_average]).to be_a Float
      expect(movie[:vote_count]).to be_a Integer
    end
  end
end
