class Member < ApplicationRecord
  belongs_to :bank
  belongs_to :user

  enum status: [ :completed, :challenged, :halted, :denied ]

  def mx
    @mx = Mx::Member.new(self)
  end

  def authentication_status
     response = mx.check_status
     binding.pry
  end
end
