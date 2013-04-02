class ErrorsController < ApplicationController
  def not_found
    @title = t('errors.not_found.title')
  end
end
