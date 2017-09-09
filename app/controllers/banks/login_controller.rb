class Banks::LoginController < ApplicationController
  def index
    @credentials = Bank.find_by_mx_id(params[:bank_mx_id]).credentials
  end

  def create
    member = current_user.member_connect(
      bank_mx_id: params[:bank_mx_id],
      credentials: login_params
    )
    member.check_status
    if member.challenged?
      redirect_to bank_authenticate_index_path(bank_mx_id: params[:bank_mx_id])
    else
      flash[:danger] = member.status
      redirect_to root_path
    end
  end

  private

  def login_params
    params[:login].values.map do |vals|
      ActionController::Parameters.new(vals).permit(:guid, :value).to_unsafe_h
    end
  end
end
