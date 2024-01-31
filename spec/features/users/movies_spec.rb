require "rails_helper"

RSpec.describe "movies page for a user", type: :feature do# US-2
  it "shows a list of top 20 movies, or a movie from the search on the discover page", :vcr do
    user = User.create!(name: 'Sam', email: 'sam@email.com')
    visit "/users/#{user.id}/discover"

    expect(page).to have_button("Top 20 Movies")
    click_button("Top 20 Movies")

    expect(current_path).to eq("/users/#{user.id}/movies")
    expect(page).to have_content("Top 20 Movies")
    expect(page).to have_link("Shawshank Redemption")
    expect(page).to have_content("Vote Average: 8.711")

    click_link("Shawshank Redemption")

    expect(current_path).to eq("/users/#{user.id}/movies/278")
    expect(page).to have_link("Return to Discover")

    click_link("Return to Discover")

    expect(current_path).to eq("/users/#{user.id}/discover")

    fill_in "search", with: "Big"
    click_button "Search"

    expect(current_path).to eq("/users/#{user.id}/movies")
    expect(page).to have_content("Searched Movie:")
    expect(page).to have_link("Big")
    expect(page).to have_content("Vote Average: 7.163")

    click_link("Big")

    expect(current_path).to eq("/users/#{user.id}/movies/2280")
    expect(page).to have_link("Return to Discover")

    click_link("Return to Discover")

    expect(current_path).to eq("/users/#{user.id}/discover")
  end
end
