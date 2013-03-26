class PagesController < ApplicationController
  require 'open-uri'
  require 'json'

  def home
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

  def testing
    @title = "Testing"
  end

  def books
    @title = "Books"
    @list = ActiveSupport::JSON.decode(open("https://www.googleapis.com/books/v1/volumes?q=#{params[:query]}").read)
  end
end
