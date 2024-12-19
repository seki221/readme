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

  private
  
  def planner_params
    params.require(:planner).permit(:title, :start_date, :end_date)
  end
end