require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should allow_value('something@something.something').for(:email) }
    it { should_not allow_value('something somthing@something.something').for(:email) }
    it { should_not allow_value('something.something@').for(:email) }
    it { should_not allow_value('something').for(:email) }

  end

  describe 'associations' do
    it { should have_many :user_parties }
    it { should have_many(:viewing_parties).through(:user_parties) }
  end

  describe "instance methods" do
    it "has a #hosted_viewing_parties method" do
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

      expect(user.hosted_viewing_parties).to include(viewing_party1)
      expect(user1.hosted_viewing_parties).to include(viewing_party2)
    end

    it "has a #viewing_parties_attended method" do
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

      expect(user.viewing_parties_attended).to include(viewing_party2)
      expect(user1.viewing_parties_attended).to include(viewing_party1)
      expect(user2.viewing_parties_attended).to include(viewing_party1, viewing_party2)
    end
  end
end
