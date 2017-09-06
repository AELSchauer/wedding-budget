require "rails_helper"

feature "User can log in" do
  context "by entering their email and password" do
    scenario "and is redirected to their dashboard" do
      user = create(:user)

      visit root_path

      expect(page).to have_content("Login")

      click_on "Login"

      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: "password"

      click_on "Continue Budgeting"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Welcome back, #{user.first_name}!")
      expect(page).to have_content("Logout")
      expect(page).to_not have_content("Login")
    end
  end

  scenario "but login is unsuccessful when the email or password is incorrect" do
      user = create(:user)

      visit root_path

      expect(page).to have_content("Login")

      click_on "Login"

      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: "test"

      click_on "Continue Budgeting"

      expect(current_path).not_to eq(dashboard_path)
      expect(current_path).to eq(login_path)
      expect(page).not_to have_content("Welcome back, #{user.first_name}!")
      expect(page).to have_content("Invalid email and/or password")
  end
end