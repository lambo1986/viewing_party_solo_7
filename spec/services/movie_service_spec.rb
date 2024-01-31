require "rails_helper"

RSpec.describe MovieService, vcr: true do# applies vcr to all tests in this file
  describe ".top_rated" do
    it "returns the top rated movies" do
      movies = MovieService.top_rated

      expect(movies.count).to eq(20)
      expect(movies.first[:title]).to eq("The Shawshank Redemption")
    end
  end

  describe ".search" do
    it "returns the movie by title entered" do
      movie = MovieService.search("Big")

      expect(movie[:title]).to eq("Big")
    end
  end

  describe ".search_by_id" do
    it "returns the movie by id entered" do
      movie = MovieService.search_by_id(2280)

      expect(movie[:title]).to eq("Big")
    end
  end
end
