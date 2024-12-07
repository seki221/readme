class SchedulesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create index show edit update destroy]
  before_action :move_to_signed_in, except: [:index]
  def index
    default_params = {
      start_at_gteq: Time.zone.now.beginning_of_month,
      start_at_lteq: Time.zone.now.end_of_month
    }
    if params[:date].present?
      selected_date = Date.parse(params[:date])
      @schedules_for_date = Schedule.where(date: selected_date).order(:start_at)
      @selected_date = selected_date
    else
      @schedules_for_date = Schedule.all.order(:start_at)
    end
    Schedule.group(:start_at){ |schedule| schedule.date }
    @dates = (Date.today - 7..Date.today + 7).to_a

    @q = Schedule.ransack(params[:q])
    @schedules = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = current_user.schedules.build(schedule_params)
    @schedule.date = @schedule.start_at.to_date
    if @schedule.save
      redirect_to schedules_path, notice: 'スケジュールが作成されました。'
    else
      render :new
    end
  end

  def next_step
    @schedule = Schedule.find(params[:id])
    # 次のステップのロジックをここに記述
    if params[:commit_next] # "次へ進む" ボタンの処理
      if @schedule.save
        redirect_to next_step_path(@schedule), notice: t('schedules.flash.created')
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
    @schedules_for_date = Schedule.where(date: @schedule.date).order(:start_at)
  end

  def update
    @schedule = Schedule.find(params[:id])
    @schedule.assign_attributes(schedule_params)
    @schedule.date = @schedule.start_at.to_date if @schedule.start_at.present?

    if @schedule.save
      redirect_to schedule_path(@schedule), notice: 'スケジュールが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    schedule = current_user.schedules.find_by(params[:id])
    schedule.destroy!
    redirect_to root_path, success: t('defaults.flash_message.deleted', item: Schedule.model_name.human)
  end


private

  def schedule_params
    params.require(:schedule).permit(:destination, :start_at, :end_at, :cost, :review, :transportation, :position, :schedule_image, :schedule_image_cache).merge(user_id:current_user.id)
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

  def move_to_signed_in
    unless user_signed_in?
      #サインインしていないユーザーはログインページが表示される
      redirect_to  '/users/sign_in'
    end
  end
end
