class Dashboard::BanksController < ApplicationController
  def index
    @members = current_user.members
  end

  def update
    member = current_user.members.find(params[:id])
    member.check_status
    redirect_to dashboard_banks_path
  end

  def destroy
    member = current_user.members.find(params[:id])
    member.destroy
    if params[:user_action] == "retry"
      redirect_to bank_login_index_path(bank_mx_id: member.bank.mx_id)
    elsif params[:user_action] == "remove"
      redirect_to dashboard_path
    end
  end
end
