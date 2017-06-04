class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  def index
    @feedbacks = Feedback.all.where(whitelist: true)
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

  def destroy
    @feedback.destroy
    redirect_to feedbacks_path
  end

  def bad_feedback
    @feedbacks = Feedback.all.where(whitelist: false)
  end

  def change_feedback_status
    Feedback.where(id: params[:id]).first.update_column( 'whitelist', true)

    redirect_to :bad_feedbacks
  end

  private

  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit(:comment, :score, :feedbacker_id, :book_id)
  end

end