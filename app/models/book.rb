class Book
  require 'open-uri'
  require 'json'

  attr_accessor :book

  def initialize(item)
    unless item.nil?
      @book = item['volumeInfo']
      @id = item['id']
    end
  end

  def get_id
    @id
  end

  def cover
    if @book.nil? or @book['imageLinks'].nil?
      'errors/no_thumbnail.png'
    else
      @book['imageLinks']['thumbnail']
    end
  end

  def get (option)
    unless @book.nil? or @book[option].nil?
      @book[option]
    end
  end
end