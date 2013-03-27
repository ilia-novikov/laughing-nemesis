class PagesController < ApplicationController
  require 'open-uri'
  require 'json'

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

  def testing
    @title = 'Testing'
  end

  def books
    @title = 'Books'
    unless params[:books].nil?
      query = URI.encode params[:books][:query]
      @list = ActiveSupport::JSON.decode(open("https://www.googleapis.com/books/v1/volumes?q=#{query}").read)
    end
  end
end
