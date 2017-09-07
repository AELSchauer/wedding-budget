class Mx::User < Mx::Base
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def register
    user_type = {type: Rails.env}.to_s
    response = query(
      :endpoint => "/users",
      :method   => :POST,
      :params   => {
        :user   => {
          is_disabled: false,
          metadata: user_type
        }
      }
    )

    if response.error.nil?
      user.mx_guid = response.user.guid
      user.save(:validate => false)
    else
      if response.error.message == "Cannot exceed user limit for client"
        puts "#{response.error.message}."
        puts "Running user reset utility now...."
        Mx::Utilities.reset_users
        puts "User reset complete."
        Kernel.abort
      else
        binding.pry
      end

    end
  end

  def login_to_bank(credentials)
    response = query(
      :endpoint => "/users/#{user.mx_guid}/members",
      :method   => :POST,
      :params   => {
        :member => {
          institution_code: credentials.bank_mx_id,
          credentials: [
            {
              guid: credentials.username.guid,
              value: credentials.username.value,
            },
            {
              guid: credentials.password.guid,
              value: credentials.password.value,
            }
          ]
        }
      }
    )
  end
end
