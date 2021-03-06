require "rails_helper"

describe "As a registered user, when I am logged in" do
  it "and I select logout, my session ends" do
    user = create(:user)
    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: "password"
    click_button "Continue Budgeting"

    click_on "Logout"

    within(".alert-success") do
      expect(page).to have_content("Logout successful")
    end

    expect(page).to_not have_link("Logout")
    expect(page).to have_content("Login")
  end
end
