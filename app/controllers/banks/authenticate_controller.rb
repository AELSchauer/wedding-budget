class Banks::AuthenticateController < ApplicationController
  def index
    @credentials = current_user.mfa_challenge_for_bank(params[:bank_mx_id])
  end

  def create
    binding.pry
  end

  private

  def challenge_params
    params[:challenge].values.map do |vals|
      ActionController::Parameters.new(vals).permit(:guid, :value).to_unsafe_h
    end
  end
end
