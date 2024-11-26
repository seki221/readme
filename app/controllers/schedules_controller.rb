class SchedulesController < ApplicationController
  before_action :authorize_user, only: [:edit, :update, :destroy]


  def index
    default_params = {
      start_at_gteq: Time.zone.now.beginning_of_month,
      start_at_lteq: Time.zone.now.end_of_month
    }

    @q = Schedule.ransack(params[:q])
    @schedules = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = current_user.schedules.build(schedule_params)
    if @schedule.save
      redirect_to schedules_path, notice: 'Schedule created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
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
