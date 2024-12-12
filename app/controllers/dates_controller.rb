class DatesController < ApplicationController
  def show
    if params[:date].present?
      @date = parse_date(params[:date])
    else
      @date = Date.today
    end

    @date = parse_date(params[:date])
    # @schedule = Schedule.find_by("DATE(start_at) = ?", @date)
    @schedule = Schedule.where(start_at: @date.beginning_of_day..@date.end_of_day).first

    # @schedule = Schedule.find(params[:id]) 
    # @schedule = Schedule.find_by(start_at: params[:date])
    @schedule = Schedule.find_by("DATE(start_at) = ?", @date)


    

    @schedules_for_start_at = Schedule.where(date: @date).order(:start_at)
    @dates = Schedule.distinct.pluck(:date).compact
  end

  def destroy
    schedule = current_user.schedules.find_by(params[:id])
    schedule.destroy
    redirect_to date_show_path(date: @schedule.start_at.to_date), notice: t('defaults.flash_message.deleted', item: Schedule.model_name.human)
  end

  private

  def parse_date(date_param)
    Date.parse(date_param)
  rescue ArgumentError
    Date.today
  end
end
