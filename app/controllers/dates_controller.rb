class DatesController < ApplicationController
  def show
    if params[:date].present?
      @date = parse_date(params[:date])
    else
      @date = Date.today
    end

    @schedules_for_start_at = Schedule.where(date: @date).order(:start_at)
    @dates = Schedule.distinct.pluck(:date).compact
  end

  private

  def parse_date(date_param)
    Date.parse(date_param)
  rescue ArgumentError
    Date.today
  end
end
