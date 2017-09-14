class AccountActivationController < ApplicationController
  def show
    session.clear
    user = User.find_by(
      activation_token: params[:id],
      email: params[:email]
    )
    if user
      user.activate_account
      session[:user_id] = user.id
      flash[:success] = "Account successfully activated"
      redirect_to dashboard_path
    else
      flash[:danger] = "Account activation failed"
      redirect_to login_path
    end
  end
end