class ApplicationController < ActionController::Base
	protect_from_forgery
	before_filter :init
  before_filter :set_locale

	include SessionsHelper

	def init
		@start_time = Time.now
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
