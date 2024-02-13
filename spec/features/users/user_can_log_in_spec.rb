require "rails_helper"

RSpec.describe "Loggin in", type: :feature do
  it "happy: allows a user to log in with credentials" do
    user = User.create!(name: "Bap", email: "doo@doo.com", password: "getit3", password_confirmation: "getit3")

    visit root_path

    expect(page).to have_link "Log In"

    click_link "Log In"

    expect(current_path).to eq(login_path)

    fill_in "Email:", with: user.email
    fill_in "Password:", with: user.password

    click_button "Log In"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content "Hello, Bap!"
  end

  it "sad: does not allow a user to log in with invalid credentials" do
    user = User.create!(name: "Bap", email: "doo@doo.com", password: "getit3", password_confirmation: "getit3")

    visit root_path

    expect(page).to have_link "Log In"

    click_link "Log In"

    expect(current_path).to eq(login_path)

    fill_in "Email:", with: user.email
    fill_in "Password:", with: "oof-doof"

    click_button "Log In"

    expect(current_path).to eq(login_path)
    expect(page).to have_content "Invalid Username or Password"
  end

  describe "location cookie" do#challenge beginning US-1
    it "happy: allows a user to log in with credentials and remember their location" do
      user = User.create!(name: "Bap", email: "doo@doo.com", password: "getit3", password_confirmation: "getit3")
      visit login_path

      expect(page).to have_button "Log In"
      expect(page).to have_field "Email:"
      expect(page).to have_field "Password:"
      expect(page).to have_field "Location:"

      fill_in "Email:", with: user.email
      fill_in "Password:", with: user.password
      fill_in "Location:", with: "San Francisco, CA"

      click_button "Log In"

      expect(current_path).to eq(user_path(user))
      expect(page).to have_content("Hello, Bap!")
      expect(page).to have_content("San Francisco, CA")
      expect(page).to have_button("Log Out")

      click_button "Log Out"

      expect(current_path).to eq(root_path)

      visit login_path

      expect(page).to have_button("Log In")
      expect(page).to have_field "Location:", with: "San Francisco, CA"
    end
  end

  describe "user session remembering" do
    it "logs in a user and keeps them logged in after visiting another website entirely" do
      user = User.create!(name: "Bap", email: "doo@doo.com", password: "getit3", password_confirmation: "getit3")
      visit login_path

      expect(page).to have_button "Log In"
      expect(page).to have_field "Email:"
      expect(page).to have_field "Password:"
      expect(page).to have_field "Location:"

      fill_in "Email:", with: user.email
      fill_in "Password:", with: user.password
      fill_in "Location:", with: "San Francisco, CA"
      click_button "Log In"

      expect(current_path).to eq(user_path(user))

      visit "http://www.google.com"
      visit user_path(user)

      expect(current_path).to eq(user_path(user))
      expect(page).to have_button("Log Out")
    end
  end

  describe "landing page after log-in and after log-out" do
    it "no longer shows login link or create an account link after login, just a log out" do
      user = User.create!(name: "Bap", email: "doo@doo.com", password: "getit3", password_confirmation: "getit3")

      visit login_path
      fill_in "Email:", with: user.email
      fill_in "Password:", with: user.password
      fill_in "Location:", with: "San Francisco, CA"
      click_button "Log In"

      expect(current_path).to eq(user_path(user))

      visit root_path

      expect(page).not_to have_link "Log In"
      expect(page).not_to have_button "Create New User"
      expect(page).to have_link "Log Out"
    end

    it "shows the login and create an account links after log-out" do
      user = User.create!(name: "Bap", email: "doo@doo.com", password: "getit3", password_confirmation: "getit3")

      visit login_path
      fill_in "Email:", with: user.email
      fill_in "Password:", with: user.password
      fill_in "Location:", with: "San Francisco, CA"
      click_button "Log In"

      expect(current_path).to eq(user_path(user))

      visit root_path

      expect(page).not_to have_link "Log In"
      expect(page).not_to have_button "Create New User"
      expect(page).to have_link "Log Out"

      click_link "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to have_link "Log In"
      expect(page).to have_button "Create New User"
      expect(page).not_to have_link "Log Out"
      expect(page).to have_content "You have successfully logged out."
    end# challenge end US-3

    it "does not show existing users to a visitor who has not logged in" do# US-4 Challenge
      user = User.create!(name: "Bap", email: "doo@doo.com", password: "getit3", password_confirmation: "getit3")
      visit root_path

      expect(page).to have_link "Log In"
      expect(page).to have_button "Create New User"
      expect(page).to have_content "Howdy!"
      expect(page).not_to have_link "Log Out"
      expect(page).not_to have_content "Existing Users"
    end

    it "does not show existing users' links to their show pages anymore, but just email addresses" do# US-5 Challenge
      user = User.create!(name: "Bap", email: "doo@doo.com", password: "getit3", password_confirmation: "getit3")

      visit login_path
      fill_in "Email:", with: user.email
      fill_in "Password:", with: user.password
      fill_in "Location:", with: "San Francisco, CA"
      click_button "Log In"

      expect(current_path).to eq(user_path(user))

      visit root_path

      expect(page).not_to have_link "Log In"
      expect(page).not_to have_button "Create New User"
      expect(page).to have_link "Log Out"
      expect(page).to have_content "#{user.email}"
      expect(page).not_to have_link "#{user.email}"
    end

    it "doesn't not allow a user to visit a user show page if they have not logged in" do# US-6 Challenge
      user = User.create!(name: "Bap", email: "doo@doo.com", password: "getit3", password_confirmation: "getit3")
      visit root_path
      visit user_path(user)

      expect(current_path).to eq(root_path)
      expect(page).to have_content "Must be logged in to access this page."
    end
  end
end
