require 'rails_helper'

RSpec.describe "User Registration Page", type: :feature do
  describe "As a visitor" do
    it "Can register a user" do

      visit "/merchants"

      within(".topnav") do
        expect(page).to have_link("Register")
        click_link "Register"
      end

      expect(current_path).to eq("/register")
      username = "Tom Brokaw"
      fill_in :name, with: username
      fill_in  :address, with: "131 Hills Ave"
      fill_in  :city, with: "Tomville"
      fill_in  :state, with: "CO"
      fill_in  :zip, with: "82828"
      fill_in  :email, with: "tombroke@gmail.com"
      fill_in  :password, with: "hiohio38298"
      fill_in  :password_confirmation, with: "hiohio38298"

      click_button "Sign-up"

      expect(current_path).to eq("/profile")

      expect(page).to have_content("Welcome, #{username}")
    end
  end
end
