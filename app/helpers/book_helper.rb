module BookHelper
  def get_list (query)
    query = URI.encode(query)
    unless query.blank?
      begin
        ActiveSupport::JSON.decode(open("https://www.googleapis.com/books/v1/volumes?q=#{query}").read)
      rescue
        flash.now[:error] = t('errors.google.books')
        nil
      end
    end
  end

  def get_book(id)
    id = URI.encode(id)
    unless id.blank?
      begin
        ActiveSupport::JSON.decode(open("https://www.googleapis.com/books/v1/volumes/#{id}").read)
      rescue
        flash.now[:error] = t('errors.google.books')
        nil
      end
    end
  end
end
