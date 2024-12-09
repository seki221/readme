class DatesController < ApplicationController
  def show
    if params[:date].present?
      @date = parse_date(params[:date])
    else
      @date = Date.today
    end
    # @schedule = Schedule.find(params[:id]) 
    # @schedule = Schedule.find_by(start_at: params[:date])
    @schedule = Schedule.find_by("DATE(start_at) = ?", params[:date])

    @schedules_for_start_at = Schedule.where(date: @date).order(:start_at)
    @dates = Schedule.distinct.pluck(:date).compact
  end

  def destroy
    schedule = current_user.schedules.find(params[:id])
    if schedule.destroy
      redirect_to date_show_path(date: schedule.start_at.to_date), notice: 'スケジュールを削除しました。'
    else
      redirect_to schedules_path, alert: 'スケジュールの削除に失敗しました。'
    end
  end

  private

  def parse_date(date_param)
    Date.parse(date_param)
  rescue ArgumentError
    Date.today
  end
end
