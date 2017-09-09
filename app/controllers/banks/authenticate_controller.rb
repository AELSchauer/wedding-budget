class Banks::AuthenticateController < ApplicationController
  def index
    member = current_user.find_member_by_bank_mx_id(params[:bank_mx_id])
    @credentials = member.mfa_challenge
  end

  def create
    member = current_user.find_member_by_bank_mx_id(params[:bank_mx_id])
    member.mx.submit_mfa_login(challenge_params)
    x = 1
    while member.requested? || member.challenged? || member.authenticated?
      member.check_status
      x += 1
      if x > 10
        put "Crap"
        Kernel.abort
      end
    end
    if member.completed?
      flash[:success] = member.status
      redirect_to dashboard_banks
    else
      flash[:danger] = member.status
      redirect_to root_path
    end
  end

  private

  def challenge_params
    params[:challenge].values.map do |vals|
      ActionController::Parameters.new(vals).permit(:guid, :value).to_unsafe_h
    end
  end
end
