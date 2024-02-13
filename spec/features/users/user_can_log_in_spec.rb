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
end
