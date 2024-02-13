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

  describe "location cookie" do
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

      click_button("Log Out")#not sure how else to make sure user is logged in or not

      expect(current_path).to eq(root_path)
      expect(page).to have_content "You have successfully logged out."
      
      visit "http://www.google.com"
      visit user_path(user)

      expect(current_path).to eq(user_path(user))
      expect(page).not_to have_button("Log Out")
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
    end
  end
end
