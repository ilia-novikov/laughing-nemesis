class Book
  attr_accessor :book

  def initialize(item)
    @book = item['volumeInfo']
    @id = item['id']
  end

  def id
    @id
  end

  def cover
    if @book['imageLinks'].nil?
      'errors/no_thumbnail.png'
    else
      @book['imageLinks']['thumbnail']
    end
  end

  def get (option)
    unless @book[option].nil?
      @book[option]
    end
  end


end