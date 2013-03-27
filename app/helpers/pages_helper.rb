module PagesHelper
  def book_cover (item)
    if item['volumeInfo']['imageLinks'].nil?
      image_tag 'errors/no_thumbnail.png', :class => 'img-rounded'
    else
      image_tag item['volumeInfo']['imageLinks']['thumbnail'], :class => 'img-rounded'
    end
  end

  def book_title (item)
    item['volumeInfo']['title']
  end

  def book_authors (item)
    item['volumeInfo']['authors']
  end
end
