class SchedulesController < ApplicationController


  def index
    default_params = {
      start_at_gteq: Time.zone.now.beginning_of_month,
      start_at_lteq: Time.zone.now.end_of_month
    }

    if params[:date].present?
      @schedules = Schedule.where(start_at: Date.parse(params[:date]).all_day)
    else
      @schedules = Schedule.all
    end

    @dates = (Date.today - 7..Date.today + 7).to_a
    @schedules = Schedule.all # 必要なら他の条件で絞り込む

    @q = Schedule.ransack(params[:q])
    @schedules = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def new
    @schedule = Schedule.new
  end

  def create
    if @schedule.save
      redirect_to new_schedule_path, notice: 'Schedule created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

private

  def schedule_params
    params.require(:schedule).permit(:destination, :start_at, :end_at, :cost, :review, :transportation, :position, :schedule_image, :schedule_image_cache)
  end
  
  def find_schedule
    @schedule = current_user.schedules.find(params[:id])
  end

  def authorize_user
    schedule = Schedule.find(params[:id])
    unless current_user.own?(schedule)
      redirect_to schedules_path, alert: "You are not authorized to perform this action."
    end
  end
end
