class Mx::Member < Mx::Base
  attr_reader :member

  def initialize(member)
    @member = member
  end

  def check_status
    response = query(
      :endpoint => "/users/#{member.user.mx_id}/members/#{member.mx_id}/status",
      :method   => :GET
    )
  end
end