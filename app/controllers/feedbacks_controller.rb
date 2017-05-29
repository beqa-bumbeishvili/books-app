class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update]

  def index
    @feedbacks = Feedback.all
  end

  def show
  end

  def new
    @feedback = Feedback.new
  end

  def edit
  end

  def create
    @feedback = Feedback.new(feedback_params)
    respond_to do |format|
      if @feedback.save
        format.html { redirect_to @feedback, notice: 'Feedback was successfully created.' }
        format.json { render :show, status: :created, location: @feedback }
      else
        format.html { render :new }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
     if @feedback.update(feedback_params)
      format.html { redirect_to @feedback, notice: 'Feedback was successfully updated.' }
      format.json { render :show, status: :created, location: @feedback }
      else
      format.html { render :new }
      format.json { render json: @feedback.errors, status: :unprocessable_entity }
     end
    end
end

  private

  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit(:comment, :score, :feedbacker, :book_id)
  end

end