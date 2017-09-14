class UserMailer < ActionMailer::Base
  # default :from => "me@mydomain.com"

  def account_activation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registration Confirmation")
  end
end
