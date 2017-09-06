class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  after_create :add_to_mx

  def mx
    @mx ||= Mx::User.new(self)
  end

  def add_to_mx
    mx.register
  end
end
