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

      expect(movie[:original_title]).to eq("Big")#original_title
    end
  end
end
