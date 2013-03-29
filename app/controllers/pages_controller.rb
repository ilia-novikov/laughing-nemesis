class PagesController < ApplicationController

  def home
    @title = 'Home'
  end

  def contact
    @title = 'Contact'
  end

  def about
    @title = 'About'
  end

  def help
    @title = 'Help'
  end


  def oauth
    @title = 'Signing in...'
    #render :layout => '_info'
    if params[:error].nil? and params[:state] == 'booklist'
      user_params = Oauth.new(params[:code]).get_session_params
      user = User.authenticate(user_params[:email], user_params[:password])
      if user.nil?
        user = User.new(user_params)
        if user.save
          sign_in user
          flash[:success] = 'Welcome to the Ruby testing!'
          redirect_to user
        end
      else
        sign_in user
        redirect_to user
      end
    else
      flash.now[:error] = t('errors.google.auth')
      redirect_to :controller => 'users', :action => 'new'
    end
  end
end
