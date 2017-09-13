class Banks::AuthenticateController < ApplicationController
  def index
    member = current_user.find_member_by_bank_mx_id(params[:bank_mx_id])
    @credentials = member.mfa_challenge
    binding.pry
  end

  def create
    member = current_user.find_member_by_bank_mx_id(params[:bank_mx_id])
    member.mx.submit_mfa_login(challenge_params)
    member.check_status
    if member.completed?
      flash[:success] = member.status
      redirect_to dashboard_banks_path
    else
      redirect_to dashboard_banks_path
    end
  end

  private

  def challenge_params
    params[:challenge].values.map do |vals|
      ActionController::Parameters.new(vals).permit(:guid, :value).to_unsafe_h
    end
  end
end
