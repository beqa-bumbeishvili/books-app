class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  def index
    @authors = Author.all
  end

  def show
  end

  def new
    @author = Author.new
    2.times { @author.books.build }
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



  def book_filter_view
    @all_authors_with_books = Author.joins('LEFT JOIN books on books.author_id = authors.id').
                                    select('books.number AS book_number, books.title AS book_title, books.published_at AS book_published_at,
                                            authors.name AS author_name, authors.last_name AS author_last_name')


    @zip_code_filter = Author.joins('LEFT JOIN books ON books.author_id = authors.id').
                              joins('LEFT JOIN addresses ON addresses.author_id = authors.id').
                              where('addresses.zip_code LIKE \'1100\'').
                              select('books.number AS book_number, books.title AS book_title, books.published_at AS book_published_at,
                                      authors.name AS author_name, authors.last_name AS author_last_name')


    @author_id_filter = Author.joins('LEFT JOIN books ON books.author_id = authors.id').
                               where('authors.id > 20').
                               select('books.number AS book_number, books.title AS book_title, books.published_at AS book_published_at,
                                       authors.name AS author_name, authors.last_name AS author_last_name')


    @author_address_filter = Author.joins('LEFT JOIN books ON books.author_id = authors.id').
                                    joins('INNER JOIN addresses ON addresses.author_id = authors.id').
                                    where('authors.id > 20').
                                    select('books.number AS book_number, books.title AS book_title, books.published_at AS book_published_at,
                                            authors.name AS author_name, authors.last_name AS author_last_name')


    @zip_code_exist = Author.joins('LEFT JOIN books ON books.author_id = authors.id').
                             joins('LEFT JOIN addresses ON addresses.author_id = authors.id').
                             where('addresses.zip_code IS NOT NULL').
                             select('books.number AS book_number, books.title AS book_title, books.published_at AS book_published_at,
                                      authors.name AS author_name, authors.last_name AS author_last_name')

    @published_at_filter = Author.joins('LEFT JOIN books ON books.author_id = authors.id').
                                  where('books.published_at > ?', DateTime.now).
                                  select('books.number AS book_number, books.title AS book_title, books.published_at AS book_published_at,
                                       authors.name AS author_name, authors.last_name AS author_last_name')



  end


  private

    def set_author
      @author = Author.find(params[:id])
    end

  def author_params
    params.require(:author).permit(:name, :last_name, :birth_date, :address_id,
                                   books_attributes: [:number, :title, :published_at])
  end

end
