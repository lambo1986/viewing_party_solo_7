class User < ApplicationRecord
   validates_presence_of :name
   validates :password_digest, presence: true
   validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

   has_many :user_parties
   has_many :viewing_parties, through: :user_parties

   has_secure_password

   enum role: %w(default manager admin)

   def hosted_viewing_parties
      ViewingParty.joins(:user_parties).where(user_parties: { user_id: id, host: true }).distinct
   end

   def viewing_parties_attended
      ViewingParty.joins(:user_parties).where.not(user_parties: { user_id: id, host: true }).distinct
   end
end
