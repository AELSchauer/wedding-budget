class AccountActivationController < ApplicationController
  def show
    session.clear
    user = User.find_by(
      activation_token: params[:id],
      email: params[:email]
    )
    if user
      user.activate_account
      @activation = true
    else
      @activation = false
    end
  end
end