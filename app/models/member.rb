class Member < ApplicationRecord
  attr_reader :mfa

  belongs_to :bank
  belongs_to :user

  enum status: [:initiated, :requested, :completed, :authenticated, :challenged, :halted, :denied]

  def mx
    @mx = Mx::Member.new(self)
  end

  def check_status
    response = mx.check_status
    update_attributes(status: response.member.status.downcase)
    self
  end

  def mfa_challenge
    response = mx.check_status
    response.member.challenges
  end

  def connection_failed?
    halted? || denied?
  end
end
