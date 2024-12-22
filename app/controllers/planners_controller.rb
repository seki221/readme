class PlannersController < ApplicationController
  before_action :authenticate_user! 
  

  def index
    @planners = Planner.all
  end

  def new
    @planner = Planner.new
  end

  def create
    @planner = current_user.planner.new(planner_params)
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
    @planner = current_user.planners.find_by(id: params[:id])
    if @planner
      @planner.destroy!
      redirect_to planners_path, status: :see_other, notice: t('defaults.flash_message.deleted', item: Planner.model_name.human)
    else
      redirect_to planners_path, status: :not_found, alert: t('defaults.flash_message.not_found', item: Planner.model_name.human)
    end
  end


  private
  
  def planner_params
    params.require(:planner).permit(:title, :start_date, :end_date)
  end
end