require "rails_helper"

RSpec.describe "Similar Movies", type: :feature, vcr: true do
  it "shows similar movies to the one from the movie details page" do# US-6
    user = User.create!(name: 'Sam', email: 'sam@email.com', password: 'password123', password_confirmation: 'password123')

    visit "/users/#{user.id}/movies/2280/similar"

    expect(page).to have_content("Movies Kinda Like Big (based on genre and plot)")
    expect(page).to have_content("Title:")
    expect(page).to have_content("Overview:")
    expect(page).to have_content("Vote Average:")
    expect(page).to have_content("Release Date:")
    expect(page).to have_content("Poster:")
  end
end
