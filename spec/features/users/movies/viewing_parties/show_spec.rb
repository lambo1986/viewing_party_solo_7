require "rails_helper"

RSpec.describe "party show page", type: :feature, vcr: true do
  it "has logos of the services to rent or buy the movie from" do
    user = User.create!(name: 'Sam', email: 'sam@email.com')
    
  end
                                                                          # as per TMDB's instructions.
  it "has a data attribution for the JustWatch platform that reads:'Buy/Rent data provided by JustWatch'" do
    user = User.create!(name: 'Sam', email: 'sam@email.com')

  end
end
