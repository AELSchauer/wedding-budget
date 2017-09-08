class User < ApplicationRecord
  has_secure_password
  has_many :members

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ },
                    uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  after_create :add_to_mx

  def mx
    @mx ||= Mx::User.new(self)
  end

  def add_to_mx
    response = mx.register
    mx_id = response.user.guid
    save(:validate => false)
  end

  def member_connect(credentials)
    status = member_login(credentials)
    binding.pry
  end

  def member_login(credentials)
    response = mx.login_to_bank(credentials)
    membership = members.find_or_create_by(
      mx_id: response.member.guid,
      bank: Bank.find_by_mx_id(response.member.institution_code)
    )
    membership.update_attributes(status: response.member.status.downcase)
    membership
  end

  def check_authentication
    
  end
end
