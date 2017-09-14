require "rails_helper"

feature "User can activate their account" do
  describe "As a unactiated user, when I open the activation link" do
    it "my account becomes activated" do
      user = create(:user)

      visit account_activation_path(user.activation_token, email: user.email)

      expect(page).to have_content("Account successfully activated")
      expect(current_path).to eq(dashboard_path)
    end

    context "if the activation link is incorrect" do
      it "my account will not become activated" do
        user = create(:user)

        visit account_activation_path(user.activation_token, email: "bad.email@email.com")

        expect(page).to have_content("Account activation failed")
        expect(current_path).to eq(login_path)
      end
    end
  end
end