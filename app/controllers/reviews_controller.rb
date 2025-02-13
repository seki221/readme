# frozen_string_literal: true

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
      redirect_to date_show_path(@schedule.start_at.to_date), notice: t('view.review.create')
    else
      redirect_to date_show_path(@schedule.start_at.to_date), alert: t('view.review.miss')
    end
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:schedule_id])
  end

  def review_params
    params.require(:review).permit(:body, :rating)
  end
end
