class ViewingParty < ApplicationRecord
   attr_accessor :movie_runtime

   has_many :user_parties
   has_many :users, through: :user_parties

   validate :duration_longer_than_movie

   def find_host
      users.where("user_parties.host = true").first
   end
end

private

def duration_longer_than_movie
   if movie_runtime.present? && duration < movie_runtime.to_i
      errors.add(:duration, "party duration must be greater than movie duration")
   end
end
