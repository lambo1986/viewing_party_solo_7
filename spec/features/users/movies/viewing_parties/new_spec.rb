require "rails_helper"

RSpec.describe "New Viewing Party Page", type: :feature, vcr: :true do# US-4
  it "Shows the movie title that the party is for" do
    user = User.create!(name: 'Sam', email: 'sam@email.com')
    user1 = User.create!(name: 'Jams', email: 'jams@email.com')
    user2 = User.create!(name: 'Ari', email: 'ari@email.com')
    user3 = User.create!(name: 'Tok', email: 'tok@email.com')
    visit("/users/#{user.id}/discover")

    fill_in "search", with: "Big"
    click_button "Search"

    expect(current_path).to eq("/users/#{user.id}/movies")
    expect(page).to have_link("Big")

    click_link("Big")

    expect(current_path).to eq "/users/#{user.id}/movies/2280"
    expect(page).to have_button("Create a Viewing Party")
    expect(page).to have_content("Title: Big")# title

    click_button("Create a Viewing Party")#begin the test.. part 1 (new party)

    expect(current_path).to eq "/users/#{user.id}/movies/#{2280}/viewing_party/new"
    expect(page).to have_content("Create a Party for Big")
    expect(page).to have_button("Return to Discover")
    expect(page).to have_field("Duration of Party")
    expect(page).to have_field("Date")
    expect(page).to have_field("Start Time")
    expect(page).to have_field(user1.name, type: 'checkbox')
    expect(page).to have_field(user2.name, type: 'checkbox')
    expect(page).to have_field(user3.name, type: 'checkbox')
    expect(page).to have_button("Create Party")

    fill_in "Duration of Party", with: "135"
    fill_in "Date", with: "03-27-24"
    fill_in "Start Time", with: "20:00"
    check(user1.name)
    check(user2.name)
    check(user3.name)
    click_button("Create Party")

    expect(current_path).to eq "/users/#{user.id}"#begin part 2 (user dashboard)
    expect(page).to have_content("Sam")
    expect(page).to have_content("Upcoming Viewing Party:")
    
  end
end
