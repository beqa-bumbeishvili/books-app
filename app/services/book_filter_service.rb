class BookFilterService
  attr_reader :custom_columns

  def initialize
    @custom_columns = 'books.number AS book_number, books.title AS book_title, books.price AS book_price, books.published_at AS book_published_at,
                                            authors.name AS author_name, authors.last_name AS author_last_name'

  end

  def all_authors_with_books
    Author.joins('LEFT JOIN books on books.author_id = authors.id').
        select(@custom_columns)
  end

  def zip_code_filter
    Author.joins('LEFT JOIN books ON books.author_id = authors.id').
           joins('LEFT JOIN addresses ON addresses.author_id = authors.id').
           where('addresses.zip_code = \'1100\'').
           select(@custom_columns)
  end

  def author_id_filter
    Author.joins('LEFT JOIN books ON books.author_id = authors.id').
           where('authors.id > 20').
           select(custom_columns)
  end

  def author_address_filter
    Author.joins('LEFT JOIN books ON books.author_id = authors.id').
           joins('INNER JOIN addresses ON addresses.author_id = authors.id').
           where('authors.id > 20').
           select(custom_columns)
  end

  def zip_code_exists
    Author.joins('LEFT JOIN books ON books.author_id = authors.id').
           joins('LEFT JOIN addresses ON addresses.author_id = authors.id').
           where('addresses.zip_code IS NOT NULL').
           select(custom_columns)
  end

  def published_at_filter
    Author.joins('LEFT JOIN books ON books.author_id = authors.id').
           where('books.published_at > ?', '2012-01-01').
           select(custom_columns)
  end

  def books_with_feedbacks
    sql = <<~SQL
        SELECT title AS book_title , number AS book_number, price AS book_price, published_at AS book_published_at FROM books
        WHERE id IN(SELECT DISTINCT(book_id) from feedbacks
                    WHERE book_id IS NOT NULL)
    SQL

    @books_with_feedbacks = Book.find_by_sql(sql)
  end

  def book_good_feedbacks
    Book.joins('LEFT JOIN feedbacks ON feedbacks.book_id = books.id').
         where('feedbacks.score > 60').
         select('books.title AS book_title , books.number AS book_number, books.price AS book_price,
                                             books.published_at AS book_published_at, feedbacks.comment AS feedback_comment,
                                             feedbacks.score AS feedback_score')
  end

  def certain_feedbacker
    Book.joins('LEFT JOIN feedbacks ON feedbacks.book_id = books.id').
         joins('LEFT JOIN users ON users.id = feedbacks.feedbacker_id').
         where('users.name = \'gia\'').
         select('books.title AS book_title , books.number AS book_number, books.price AS book_price,
                                             books.published_at AS book_published_at, feedbacks.comment AS feedback_comment,
                                             feedbacks.score AS feedback_score')
  end

  def users_with_many_contacts
    users_sql = <<~SQL
      SELECT * FROM users
            WHERE id IN (
            SELECT user_id
            FROM address_books
            GROUP BY user_id
            HAVING COUNT(*) > 1
            )
    SQL

    User.find_by_sql(users_sql)
  end

  def feedbackers
    User.where('id IN (:array)', array: Feedback.distinct.pluck(:feedbacker_id))
  end

  def user
    user_id_sql = <<~SQL
      SELECT * FROM users
      WHERE id IN (
        SELECT user_id
        FROM address_books
        GROUP BY user_id
        HAVING COUNT(*) >= 1
        ORDER BY COUNT(*) DESC
        LIMIT 1
        )
    SQL

    User.find_by_sql(user_id_sql)
  end


end