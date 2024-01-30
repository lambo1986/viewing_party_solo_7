require "rails_helper"

RSpec.describe "movies page for a user", type: :feature do# US-2
  it "shows a list of top 20 movies, or a movie from the search on the discover page", :vcr do
    visit "/users/1/discover"

    expect(page).to have_button("Top 20 Movies")
    click_button("Top 20 Movies")
    expect(current_path).to eq("/users/1/movies")

    visit "/users/1/discover"

    fill_in "search", with: "Big"
    click_button "Search"
    expect(current_path).to eq("/users/1/movies")
  end
end
