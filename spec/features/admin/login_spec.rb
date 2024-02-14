require "rails_helper"

RSpec.describe "Admin login", type: :feature do# challenge extension
  describe "happy path" do
    it "allows admin to login and goes to their dashboard" do
      user1 = User.create!(name: "Bap", email: "doo@doo.com", password: "getit3", password_confirmation: "getit3")
      user2 = User.create!(name: "Goose", email: "sparks@dools.com", password: "shimmy", password_confirmation: "shimmy")
      admin = User.create!(name: "Bill", email: "bossman@co.com", password: "basspro", password_confirmation: "basspro", role: 2)

      visit login_path
      fill_in "Email:", with: admin.email
      fill_in "Password:", with: admin.password
      fill_in "Location:", with: "San Francisco, CA"
      click_button "Log In"

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Admin Dashboard")
      expect(page).to have_content("Default Users:")
      expect(page).to have_link(user1.email)
      expect(page).to have_link(user2.email)

      click_link(user1.email)

      expect(current_path).to eq("/admin/users/#{user1.id}")
    end
  end

  describe "as default user" do
    it 'does not allow default user to see admin dashboard index' do
      user1 = User.create!(name: "Bap", email: "doo@doo.com", password: "getit3", password_confirmation: "getit3")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit admin_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
