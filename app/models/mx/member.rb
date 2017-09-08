class Mx::Member < Mx::Base
  attr_reader :member, :status, :mfa

  def initialize(member)
    @member = member
    @status = ""
    @mfa    = {}
  end

  def check_status
    response = query(
      :endpoint => "/users/#{member.user.mx_id}/members/#{member.mx_id}",
      :method   => :GET
    )
    data = response.member
    status = data.status
    binding.pry
    mfa    = ["challenges"].each do |mfa_type|
      mfa.merge(mfa_type => data[mfa_type] unless data[mfa_type].nil?)
    end
  end
end