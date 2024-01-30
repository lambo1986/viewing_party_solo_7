require "rails_helper"#why this over spec_helper?

RSpec.describe "user's discover page (/users/:id/discover)", type: :feature do# US-1
  describe "happy path" do
    it "allows users to search for a movie by title" do
      visit "/users/1/discover"
      fill_in "search", with: "Big"
      click_button "Search"

      expect(current_path).to eq("users/:user_id/movies")#movie results page (will come in US-2)

    end
  end
end
