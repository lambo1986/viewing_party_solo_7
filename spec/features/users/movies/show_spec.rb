require "rails_helper"

RSpec.describe "Movie's detail page", type: :feature do# US-3
  it "has a button to go back to the discover page, a button to create a viewing party, and many movie details", :vcr do
    user = User.create!(name: 'Sam', email: 'sam@email.com', password: 'password123', password_confirmation: 'password123')

    visit login_path
    fill_in "Email:", with: user.email
    fill_in "Password:", with: user.password
    fill_in "Location:", with: "San Francisco, CA"
    click_button "Log In"

    visit("/users/#{user.id}/discover")

    fill_in "search", with: "Big"
    click_button "Search"

    expect(current_path).to eq("/users/#{user.id}/movies")
    expect(page).to have_content("Searched Movie:")
    expect(page).to have_link("Big")
    expect(page).to have_content("Vote Average: 7.164")

    click_link("Big")

    expect(current_path).to eq "/users/#{user.id}/movies/2280"# we have arrived
    expect(page).to have_button("Return to Discover")
    expect(page).to have_content("Movie Information")
    expect(page).to have_button("Create a Viewing Party")
    expect(page).to have_content("Title: Big")
    expect(page).to have_content("Vote Average: 7.164")
    expect(page).to have_content("Vote Count: 3395")
    expect(page).to have_content("Summary: When a young boy makes a wish")
    expect(page).to have_content("Genre:")
    expect(page).to have_content("Runtime:")
    expect(page).to have_content("Cast Members:")
    expect(page).to have_content("Reviews Count:")
    expect(page).to have_content("Review Author:")
    expect(page).to have_content("Review Content:")

    click_button("Create a Viewing Party")

    expect(current_path).to eq "/users/#{user.id}/movies/2280/viewing_party/new"
  end

  it "has a link to 'Get Similar Movies'" do# US-6
    user = User.create!(name: 'Sam', email: 'sam@email.com', password: 'password123', password_confirmation: 'password123')

    visit "/users/#{user.id}/movies/2280"

    expect(current_path).to eq "/users/#{user.id}/movies/2280"
    expect(page).to have_link("Get Similar Movies")

    click_link("Get Similar Movies")

    expect(current_path).to eq "/users/#{user.id}/movies/2280/similar"
  end
end
