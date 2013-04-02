class BookController < ApplicationController
  def search
    @title = t('books.search.title')

    unless params[:modification].nil?
      if params[:modification][:book_action] == 'add'
        current_user.list.add_book(params[:modification][:book_id])
        flash.now[:success] = t('books.search.actions.added', :title => '???')
      end
      if params[:modification][:book_action] == 'remove'
        current_user.list.remove_book(params[:modification][:book_id])
        flash.now[:success] = t('books.search.actions.removed', :title => '???')
      end
      unless params[:modification][:redirect].nil?
        redirect_to params[:modification][:redirect]
      end
    end
  end

  def info

  end
end
