class PagesController < ApplicationController

  def home
    @title = t('pages.home.title')
  end

  def contact
    @title = t('pages.contact.title')
  end

  def about
    @title = t('pages.about.title')
  end

  def help
    @title = t('pages.help.title')
  end


  def oauth
    @title = t('pages.oauth.title')
    #render :layout => '_info'
    if params[:error].nil? and params[:state] == 'booklist'
      user_params = Oauth.new(params[:code]).get_session_params
      user = User.authenticate(user_params[:email], user_params[:password])
      if user.nil?
        user = User.new(user_params)
        list = List.new()
        list.user = user
        if user.save and list.save
          sign_in user
          flash[:success] = t('users.messages.welcome')
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
