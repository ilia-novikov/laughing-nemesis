class ApplicationController < ActionController::Base
	protect_from_forgery
	before_filter :init
	include SessionsHelper

	def init
		@start_time = Time.now
	end
end
