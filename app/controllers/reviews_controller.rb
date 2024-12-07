class ReviewsController < ApplicationController
  before_action :set_schedule
  def new
    @schedule_for_start_at = Schedule.find_by(start_at: params[:date]) 
    @review = @schedule_for_start_at.reviews.build
  end

  def create
    @schedule = Schedule.find(params[:schedule_id])
    @review = @schedule.reviews.build(review_params)
    if @review.save
      redirect_to date_show_path(@schedule.start_at.to_date), notice: 'レビューが作成されました。'
    else
      redirect_to date_show_path(@schedule.start_at.to_date), alert: 'レビューの作成に失敗しました。'
    end
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:schedule_id])
  end

  def review_params
    params.require(:review).permit(:body,:rating)
  end
end
