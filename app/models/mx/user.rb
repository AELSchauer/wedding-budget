class Mx::User < Mx::Base
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def read
    query(
      :endpoint => "/users/#{user.mx_id}",
      :method   => :GET
    )
  end

  def register
    user_type = { type: Rails.env }.to_s
    response = query(
      :endpoint => "/users",
      :method   => :POST,
      :params   => {
        :user   => {
          is_disabled: true,
          metadata: user_type
        }
      }
    )

    if response.error.nil?
      response
    elsif response.error.message == "Cannot exceed user limit for client"
      puts "#{response.error.message}."
      puts "Running user reset utility now...."
      Mx::Utilities.reset_users
      puts "User reset complete."
      Kernel.abort
    else
      binding.pry
    end
  end

  def account_verification
    query(
      :endpoint => "/users/#{user.mx_id}",
      :method   => :PUT,
      :params   => {
        :user   => {
          is_disabled: false
        }
      }
    )
  end

  def login_to_bank(data)
    query(
      :endpoint => "/users/#{user.mx_id}/members",
      :method   => :PUT,
      :params   => {
        :member => {
          institution_code: data[:bank_mx_id],
          credentials: data[:credentials]
        }
      }
    )
  end
end
