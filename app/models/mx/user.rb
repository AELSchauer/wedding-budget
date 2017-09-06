class Mx::User < Mx::Base
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def register
    response = query(
      :endpoint => "/users",
      :method   => :POST,
      :params   => {
        user: {
          is_disabled: true
        }
      }
    )

    if response.error.nil?
      user.mx_guid = response.user.guid
      user.save(:validate => false)
    else
      binding.pry
    end
  end
end
