class UserNotify < ActionMailer::Base
  default :from => "no-reply@booker.com"

  def welcome(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
end
