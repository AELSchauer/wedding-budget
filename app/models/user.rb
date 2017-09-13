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
    update_attributes(mx_id: response.user.guid)
    save(:validate => false)
  end

  def member_connect(data)
    member_login(data)
    @member.check_status
  end

  def member_login(data)
    @member = members.find_or_create_by(
      bank: Bank.find_by_mx_id(data[:bank_mx_id])
    )
    response = mx.login_to_bank(data)
    @member.update_attributes(
      mx_id: response.member.guid,
      status: response.member.status.downcase
    )
  end

  def find_member_by_bank_mx_id(bank_mx_id)
    members.find_by(bank: Bank.find_by_mx_id(bank_mx_id))
  end
end
