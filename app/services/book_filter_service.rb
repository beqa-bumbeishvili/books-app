class BookFilterService

  def self.custom_columns
    'books.number AS book_number, books.title AS book_title, books.price AS book_price, books.published_at AS book_published_at,
                                            authors.name AS author_name, authors.last_name AS author_last_name'
  end

  def self.all_authors_with_books
    Author.joins('LEFT JOIN books on books.author_id = authors.id').
        select(custom_columns)
  end


end