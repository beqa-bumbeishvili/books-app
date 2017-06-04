class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  def index
    @authors = Author.all
  end

  def show
  end

  def new
    @author = Author.new
    3.times { @author.books.build }
  end

  def edit
    @books = @author.books
  end

  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: 'Author was successfully created.' }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: 'Author was successfully updated.' }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: 'Author was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def two_books_author
    @author = Author.new
  end

  def create_author_two_books
    @author = Author.new(author_params)
    @author.books.build(title: 'gocha')
    @author.books.build(title: 'xvicha')
    @author.save
  end

  def custom_columns
    'books.number AS book_number, books.title AS book_title, books.price AS book_price, books.published_at AS book_published_at,
                                            authors.name AS author_name, authors.last_name AS author_last_name'
  end


  def book_filter_view
    @all_authors_with_books = Author.joins('LEFT JOIN books on books.author_id = authors.id').
                                    select(custom_columns)


    @zip_code_filter = Author.joins('LEFT JOIN books ON books.author_id = authors.id').
                              joins('LEFT JOIN addresses ON addresses.author_id = authors.id').
                              where('addresses.zip_code = \'1100\'').
                              select(custom_columns)


    @author_id_filter = Author.joins('LEFT JOIN books ON books.author_id = authors.id').
                               where('authors.id > 20').
                               select(custom_columns)


    @author_address_filter = Author.joins('LEFT JOIN books ON books.author_id = authors.id').
                                    joins('INNER JOIN addresses ON addresses.author_id = authors.id').
                                    where('authors.id > 20').
                                    select(custom_columns)

    @zip_code_exist = Author.joins('LEFT JOIN books ON books.author_id = authors.id').
                             joins('LEFT JOIN addresses ON addresses.author_id = authors.id').
                             where('addresses.zip_code IS NOT NULL').
                             select(custom_columns)

    @published_at_filter = Author.joins('LEFT JOIN books ON books.author_id = authors.id').
                                  where('books.published_at > ?', '2012-01-01').
                                  select(custom_columns)

    sql = <<~SQL
        SELECT title AS book_title , number AS book_number, price AS book_price, published_at AS book_published_at FROM books
        WHERE id IN(SELECT DISTINCT(book_id) from feedbacks
                    WHERE book_id IS NOT NULL)
    SQL

    @books_with_feedbacks = Book.find_by_sql(sql)

    @books_with_good_feedbacks = Book.joins('LEFT JOIN feedbacks ON feedbacks.book_id = books.id').
                                      where('feedbacks.score > 60').
                                      select('books.title AS book_title , books.number AS book_number, books.price AS book_price,
                                             books.published_at AS book_published_at, feedbacks.comment AS feedback_comment,
                                             feedbacks.score AS feedback_score')

    @gia_feedbacker = Book.joins('LEFT JOIN feedbacks ON feedbacks.book_id = books.id').
                           joins('LEFT JOIN users ON users.id = feedbacks.feedbacker_id').
                           where('users.name = \'gia\'').
                           select('books.title AS book_title , books.number AS book_number, books.price AS book_price,
                                             books.published_at AS book_published_at, feedbacks.comment AS feedback_comment,
                                             feedbacks.score AS feedback_score')

    users_sql = <<~SQL
      SELECT * FROM users
            WHERE id IN (
            SELECT user_id
            FROM address_books
            GROUP BY user_id
            HAVING COUNT(*) > 1
            )
    SQL

    @users_with_many_contacts = User.find_by_sql(users_sql)

    feedbackers_sql = <<~SQL
        SELECT * FROM users
        WHERE id IN (
        SELECT DISTINCT feedbacker_id
        FROM feedbacks
        )
    SQL

    @feedbackers = User.find_by_sql(feedbackers_sql)

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

    @user = User.find_by_sql(user_id_sql)

  end

  private

    def set_author
      @author = Author.find(params[:id])
    end

  def author_params
    params.require(:author).permit(:name, :last_name, :birth_date, :address_id,
                                   books_attributes: [:id, :number, :title, :published_at])
  end

end
