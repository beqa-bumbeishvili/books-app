class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.all
  end

  def show
  end

  # GET /authors/new
  def new
    @author = Author.new
    3.times { @author.books.build }
  end

  # GET /authors/1/edit
  def edit
    @author.books
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(author_params)
    respond_to do |format|
      if @author.save
        params[:author][:books_attributes].to_a.each { |item| Book.create(author_id: @author.id, number: item[1]['number'], title: item[1]['title'] ) }
        format.html { redirect_to @author, notice: 'Author was successfully created.' }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1
  # PATCH/PUT /authors/1.json
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

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: 'Author was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def author_params
    params.require(:author).permit(:name, :last_name, :birth_date, :address_id)
  end

  def author_with_book_params
    params.require(:author).permit(:name, :last_name, :birth_date, :address_id,
                                   books_attributes: [ :id, :number, :title,])
  end
end
