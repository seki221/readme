class PlannersController < ApplicationController
  before_action :authenticate_user! 
  before_action :find_planner, only: %i[edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]
  

  def index
    @planners = Planner.all
  end

  def new
    @planner = Planner.new
  end

  def create
    @planner = current_user.planners.new(planner_params)
    @planner.start_date = @planner.start_date.change(hour: 0, min: 0, sec: 0) if @planner.start_date.present?
    @planner.end_date = @planner.end_date.change(hour: 23, min: 59, sec: 59) if @planner.end_date.present?
    if @planner.save
      redirect_to @planner, notice: t('defaults.flash_message.created')
    else
      render :new
    end
  end

  def show
    @planner = Planner.find(params[:id]) 
    @schedules = @planner.schedules
  end

  def update
    @planner = current_user.planners.find(params[:id])
    if @planner.update(planner_params)
      redirect_to @planner, notice: 'Planner was successfully updated.'
    else
      render :edit
    end
  end

  def edit
  @planner = current_user.planners.find(params[:id])
  end


  def destroy
    # binding.break
    planner = current_user.planners.find(params[:id])
    if planner
      planner.destroy
      redirect_to root_path, notice: t('defaults.flash_message.deleted', item: Planner.model_name.human)
    else
      redirect_to planners_path, alert: t('defaults.flash_message.not_found', item: Planner.model_name.human)

    end
  end


  private
  
  def planner_params
    params.require(:planner).permit(:title, :start_date, :end_date)
  end

  def correct_user
    @planner = current_user.planners.find(params[:id])
    raise ActiveRecord::RecordNotFound unless @planner.user == current_user
  end

  def find_planner
    @planner = current_user.planners.find(params[:id])
  end
end