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
    @author = Author.new(author_with_book_params)

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
      if @author.update(author_with_book_params)
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

  private

    def set_author
      @author = Author.find(params[:id])
    end


  def author_params
    params.require(:author).permit(:name, :last_name, :birth_date, :address_id)
  end

  def author_with_book_params
    params.require(:author).permit(:name, :last_name, :birth_date, :address_id,
                                   books_attributes: [:number, :title])
  end
end
