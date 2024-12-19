class SchedulesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create index show edit update destroy]
  before_action :move_to_signed_in, except: [:index]
  before_action :set_planner
  # before_action :set_ransack
  def index
    @schedules = @planner.schedules
    # デフォルトのransack条件
    # default_params = {
    #   start_at_gteq: Time.zone.now.beginning_of_month,
    #   start_at_lteq: Time.zone.now.end_of_month
    # }
    # @q = Schedule.ransack(params[:q] || default_params)
    @schedules = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def new
    @schedule = Schedule.new
    @planner = Planner.find(params[:planner_id])
    # @planner = Planner.new
  end

  def create
    # @schedule = current_user.schedules.build(schedule_params)
    @planner = Planner.find(params[:planner_id])
    @schedule = @planner.schedules.build(schedule_params)
    @schedule.user = current_user

    if @schedule.start_date.present?
      # @planner = Planner.find_or_create_by(date: @schedule.start_date.to_date)
      @planner = Planner.find_or_create_by(start_date: @schedule.start_date.to_date)

      @planner.schedules << @schedule # Planner と Schedule を関連付け
    end

    if @schedule.save
      redirect_to root_path, notice: 'スケジュールが作成されました。'
    else
      render :new
    end
  end

  def update
    @schedule = Schedule.find(params[:id])
    @planner = Planner.find(params[:id])
    @schedule.assign_attributes(schedule_params)
    @schedule.date = @schedule.start_at.to_date if @schedule.start_at.present?
    # @planner = Planner.find_or_create_by(start_date: @schedule.start_date.to_date)

    if @schedule.save
      redirect_to date_show_path(date: @schedule.start_at.to_date), notice: 'スケジュールが更新されました。'
      
    else
      render :edit
    end
  end

  def show
    @schedule = Schedule.find(params[:id])
    @planners = @schedule.planners
    @schedules_for_date = Schedule.where(date: @schedule.date).order(:start_at)
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    flash[:notice_destroy] = "スケジュールを削除しました"
    redirect_to :date
  end

  # def next_step
  #   @schedule = current_user.schedules.build(schedule_params)
  #   # 次のステップのロジックをここに記述
  #   if params[:commit_next] # "次へ進む" ボタンの処理
  #     if @schedule.save
  #       redirect_to next_step_path(@schedule), notice: t('schedules.flash.created')
  #     else
  #       render :new, status: :unprocessable_entity
  #     end
  #   end
  # end
# ↑なくす前提で





private

  def schedule_params
    params.require(:schedule).permit(:title, :start_date, :end_date, :cost, :transportation, :place, :guaid)
  end

  def find_schedule
    @schedule = current_user.schedules.find(params[:id])
  end

  def set_planner
    @planner = Planner.find(params[:planner_id])
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
