require "rails_helper"

RSpec.describe "Movie's detail page", type: :feature do
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

    expect(current_path).to eq "/users/#{user.id}/movies/2280"
    expect(page).to have_button("Return to Discover")
    expect(page).to have_content("Movie Information")
    expect(page).to have_button("Create a Viewing Party")
    expect(page).to have_content("Title: Big")# title
    expect(page).to have_content("Vote Average: 7.163")# vote_average
    expect(page).to have_content("Vote Count: 3384")# vote_count
    expect(page).to have_content("Summary: When a young boy makes a wish")# overview
  end
end
