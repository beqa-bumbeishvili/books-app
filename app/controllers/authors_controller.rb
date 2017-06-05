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


  def book_filter_view

    service = BookFilterService.new

    @all_authors_with_books = service.all_authors_with_books

    @zip_code_filter = service.zip_code_filter

    @author_id_filter = service.author_id_filter

    @author_address_filter = service.author_address_filter

    @zip_code_exist = service.zip_code_exists

    @published_at_filter = service.published_at_filter

    @books_with_feedbacks = service.books_with_feedbacks

    @books_with_good_feedbacks = service.book_good_feedbacks

    @gia_feedbacker = service.certain_feedbacker

    @users_with_many_contacts = service.users_with_many_contacts

    @feedbackers = service.feedbackers

    @user = service.user
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
