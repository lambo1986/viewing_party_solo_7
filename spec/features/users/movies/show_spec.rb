require "rails_helper"

RSpec.describe "Movie's detail page", type: :feature do# US-3
  it "has a button to go back to the discover page, a button to create a viewing party, and many movie details", :vcr do
    user = User.create!(name: 'Sam', email: 'sam@email.com')

    visit("/users/#{user.id}/discover")

    fill_in "search", with: "Big"
    click_button "Search"

    expect(current_path).to eq("/users/#{user.id}/movies")
    expect(page).to have_content("Searched Movie:")
    expect(page).to have_link("Big")
    expect(page).to have_content("Vote Average: 7.163")

    click_link("Big")

    expect(current_path).to eq "/users/#{user.id}/movies/2280"# we have arrived
    expect(page).to have_button("Return to Discover")
    expect(page).to have_content("Movie Information")
    expect(page).to have_button("Create a Viewing Party")
    expect(page).to have_content("Title: Big")# title
    expect(page).to have_content("Vote Average: 7.163")# vote_average
    expect(page).to have_content("Vote Count: 3384")# vote_count
    expect(page).to have_content("Summary: When a young boy makes a wish")# overview
    expect(page).to have_content("Genre:")# 14, 18, 35, 10749, 10751
    expect(page).to have_content("Runtime:")# 1hr 44min
    expect(page).to have_content("Cast Members:")# first 10
    expect(page).to have_content("Reviews Count:")
    expect(page).to have_content("Review Author:")
    expect(page).to have_content("Review Content:")

    click_button("Create a Viewing Party")

    expect(current_path).to eq "/users/#{user.id}/movies/2280/viewing_party/new"
  end

  it "has a link to 'Get Similar Movies'" do# US-6
    user = User.create!(name: 'Sam', email: 'sam@email.com')

    visit "/users/#{user.id}/movies/2280"

    expect(current_path).to eq "/users/#{user.id}/movies/2280"
    expect(page).to have_link("Get Similar Movies")

    click_link("Get Similar Movies")

    expect(current_path).to eq "/users/#{user.id}/movies/2280/similar"
  end
end
