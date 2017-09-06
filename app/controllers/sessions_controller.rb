class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: login_params[:email])

    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{user.first_name}!"
      redirect_to dashboard_path
    else
      flash[:danger] = "Invalid email and/or password"
      render :new
    end
  end

  def destroy
    session.clear
      flash[:success] = "Logout successful"
    redirect_to root_path
  end

  private

  def login_params
    params.require(:session).permit(:email, :password)
  end
end
