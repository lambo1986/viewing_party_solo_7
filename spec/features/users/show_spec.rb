require "rails_helper"

RSpec.describe "user dashboard", type: :feature, vcr: true do
  it "has parties user has been invited to with details and a link to the movie" do# US-7
    user = User.create!(name: 'Sam', email: 'sam@email.com')
    user1 = User.create!(name: 'Jams', email: 'jams@email.com')
    user2 = User.create!(name: 'Ari', email: 'ari@email.com')
    user3 = User.create!(name: 'Tok', email: 'tok@email.com')
    movie1 = MovieService.search_by_id(2280)#big
    movie2 = MovieService.search_by_id(238)#godfather
    viewing_party1 = ViewingParty.create!(duration: 135, date: "2020-01-01", start_time: "12:00", movie_id: 2280)#sam
    viewing_party2 = ViewingParty.create!(duration: 235, date: "2021-02-03", start_time: "11:30", movie_id: 238)#jams
    user_party1 = UserParty.create!(user: user, viewing_party: viewing_party1, host: true)# sam host
    user_party2 = UserParty.create!(user: user1, viewing_party: viewing_party2, host: true)# jams host

    viewing_party1.users << [user1, user2, user3]# sam invites Jams, Ari, Tok
    viewing_party2.users << [user, user2, user3]# jams invites sam, Ari, Tok

    visit "/users/#{user.id}"

    expect(page).to have_content("Sam's Dashboard")
    expect(page).to have_content("Upcoming Viewing Party:")
    expect(page).to have_content("Host: Sam")
    expect(page).to have_content("Host: Jams")
    expect(page).to have_content("Attending As Guest:")
    expect(page).to have_content("Hosted Party:")

    click_link "The Godfather"

    expect(page).to have_content("Movie Information")
    expect(page).to have_content("Title: The Godfather")
  end

  it "has a button to discover movies" do# added for smooth rails server experience (can get anywhere from root now)
    user = User.create!(name: 'Sam', email: 'sam@email.com')

    visit "/users/#{user.id}"

    expect(page).to have_button("Discover Movies")

    click_button "Discover Movies"

    expect(current_path).to eq("/users/#{user.id}/discover")
  end

  it "has a button to see where to rent or buy movie" do
    user = User.create!(name: 'Sam', email: 'sam@email.com')
    user1 = User.create!(name: 'Jams', email: 'jams@email.com')
    user2 = User.create!(name: 'Ari', email: 'ari@email.com')
    user3 = User.create!(name: 'Tok', email: 'tok@email.com')
    movie1 = MovieService.search_by_id(2280)#big
    movie2 = MovieService.search_by_id(238)#godfather
    viewing_party1 = ViewingParty.create!(duration: 135, date: "2020-01-01", start_time: "12:00", movie_id: 2280)#sam
    viewing_party2 = ViewingParty.create!(duration: 235, date: "2021-02-03", start_time: "11:30", movie_id: 238)#jams
    user_party1 = UserParty.create!(user: user, viewing_party: viewing_party1, host: true)# sam host
    user_party2 = UserParty.create!(user: user1, viewing_party: viewing_party2, host: true)# jams host

    viewing_party1.users << [user1, user2, user3]# sam invites Jams, Ari, Tok
    viewing_party2.users << [user, user2, user3]# jams invites sam, Ari, Tok

    visit "/users/#{user.id}"

    expect(page).to have_button("Where to Watch")
  end
end
