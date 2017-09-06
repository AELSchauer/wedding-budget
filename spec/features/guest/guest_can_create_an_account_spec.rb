require "rails_helper"

feature "Guest" do
  scenario "can create an account" do
    visit signup_path

    fill_in "user[first_name]", with: "Charlie"
    fill_in "user[last_name]", with: "Cat"
    fill_in "user[email]", with: "charlie.cat@email.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"

    expect { click_on "Start Budgeting" }.to change(User, :count).by(1)

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Charlie's Dashboard")
    expect(page).to have_link("Logout")
    expect(page).to_not have_link("Signup")
  end

  it "can't create an account without all user information or duplicate information" do
    user = User.create!(
      first_name: "Darcy",
      last_name: "Dog",
      email: "darcy.dog@email.com",
      password: "password",
      password_confirmation: "password"
    )

    visit signup_path

    fill_in "user[first_name]", with: "Darcy"
    fill_in "user[last_name]", with: "Dog"
    fill_in "user[email]", with: "darcy.dog@email.com"

    click_on "Start Budgeting"

    expect(page).to have_content("Email has already been taken")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_link("Signup")

    expect(page).to_not have_content("Darcy's Dashboard")
    expect(page).to_not have_link("Logout")
  end
end
