class SessionsController < ApplicationController
  def new
    @title = t('sessions.title')
  end

  def create
    if params[:commit] == t('sessions.sign_in')
      user = User.authenticate(params[:session][:email], params[:session][:password])
      if user.nil?
        flash.now[:error] = t('errors.wrong_password')
        @title = t('sessions.title')
        render 'new'
      else
        sign_in user
        redirect_to user
      end
    else
      redirect_to :controller => 'users', :action => 'new', :email => params[:session][:email]
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
