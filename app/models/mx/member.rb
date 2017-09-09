class Mx::Member < Mx::Base
  attr_reader :member

  def initialize(member)
    @member = member
  end

  def check_status
    query(
      :endpoint => "/users/#{member.user.mx_id}/members/#{member.mx_id}/status",
      :method   => :GET
    )
  end

  def submit_mfa_login(credentials)
    query(
      :endpoint => "/users/#{member.user.mx_id}/members/#{member.mx_id}/resume",
      :method   => :PUT,
      :params   => {
        :member => {
          challenges: credentials
        }
      }
    )
  end

  def delete
    query(
      :endpoint => "/users/#{member.user.mx_id}/members/#{member.mx_id}",
      :method   => :DELETE
    )
  end
end