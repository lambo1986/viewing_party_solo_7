class ViewingParty < ApplicationRecord
   validate :duration_longer_than_movie# brainstorming

   has_many :user_parties
   has_many :users, through: :user_parties

   def find_host
      users.where("user_parties.host = true").first
   end
end

private

def duration_longer_than_movie# brainstorming

end
