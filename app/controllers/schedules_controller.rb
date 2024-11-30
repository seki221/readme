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
    @schedule = current_user.schedules.build(schedule_params)
    if params[:commit_create] # "スケジュールを作成" ボタンの処理
      if @schedule.save
        redirect_to schedules_path, notice: t('schedules.flash.created')
      else
        render :new, status: :unprocessable_entity
      end
    elsif params[:commit_next] # "次へ進む" ボタンの処理
      if @schedule.save
        redirect_to next_step_path(@schedule)
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def update
        @schedule = current_user.schedules.find(params[:id])
    if @schedule.update(schedule_params)
      redirect_to schedule_path(@schedule), success: t('defaults.flash_message.updated', item: @schedule.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_updated', item: @schedule.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    schedule = current_user.schedules.find_by(id: params[:id])
    schedule.destroy!
    redirect_to schedules_path,success: t('defaults.flash_message.deleted', item: Schedule.model_name.human)
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
