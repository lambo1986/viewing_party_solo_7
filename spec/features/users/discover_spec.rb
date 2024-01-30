require "rails_helper"#why this over spec_helper?

RSpec.describe "user's discover page (/users/:id/discover)", type: :feature do# US-1
  describe "discover and search" do
    it "allows users to search for a movie by title or discover top rated movies" do
      visit "/users/1/discover"

      expect(page).to have_button("Top 20 Movies")
      click_button("Top 20 Movies")
      expect(current_path).to eq("/users/1/movies")# movie results page (will come in US-2)

      visit "/users/1/discover"

      fill_in "search", with: "Big"
      click_button "Search"
      expect(current_path).to eq("/users/1/movies")# movie results page (will come in US-2)
    end
  end
end
