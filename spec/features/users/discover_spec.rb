require "rails_helper"

RSpec.describe "user's discover page (/users/:id/discover)", type: :feature do# US-1
  describe "discover and search" do
    it "allows users to search for a movie by title or discover top rated movies" do
      user = User.create!(name: 'Sam', email: 'sam@email.com')
      visit "/users/#{user.id}/discover"

      expect(page).to have_button("Top 20 Movies")
      click_button("Top 20 Movies")
      expect(current_path).to eq("/users/#{user.id}/movies")# movie results page (will come in US-2)

      visit "/users/#{user.id}/discover"

      fill_in "search", with: "Big"
      click_button "Search"
      expect(current_path).to eq("/users/#{user.id}/movies")# movie results page (will come in US-2)
    end
  end
end
