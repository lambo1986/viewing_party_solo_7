class AddMovieToUserParties < ActiveRecord::Migration[7.1]
  def change
    add_column :user_parties, :movie, :integer
  end
end
