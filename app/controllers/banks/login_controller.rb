class Banks::LoginController < ApplicationController
  def index
    @credentials = Bank.find_by_mx_id(params[:bank_mx_id]).credentials
  end

  def create
    current_user.member_connect(login_params)
  end

  private

  def login_params
    Hashie::Mash.new(
      bank_mx_id: params[:bank_mx_id],
      username: {
        guid: params["login"]["username_guid"],
        value: params["login"]["username"]
      },
      password: {
        guid: params["login"]["password_guid"],
        value: params["login"]["password"]
      }
    )
  end
end
