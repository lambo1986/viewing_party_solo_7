require "rails_helper"

RSpec.describe "party show page", type: :feature, vcr: true do# US-5
  it "has logos of the services to rent or buy the movie from" do
    user = User.create!(name: 'Sam', email: 'sam@email.com')
    viewing_party = ViewingParty.create!(duration: 135, date: "2020-01-01", start_time: "12:00")
    user_party = user.user_parties.create!(host: true, viewing_party_id: viewing_party.id, user_id: user.id)

    visit "/users/#{user.id}/movies/2280/viewing_party/#{viewing_party.id}"

    expect(page).to have_content("Where to Watch Big?")
    expect(page).to have_content("(Data Attribution: Buy/Rent data provided by JustWatch)")
    expect(page).to have_content("Where to Buy")
    expect(page).to have_content("Where to Rent")
  end
end
