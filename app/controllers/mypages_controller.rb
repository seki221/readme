class MypagesController < ApplicationController
  before_action :authenticate_user! 
  before_action :correct_user, only: %i[index show edit update destroy]

  def index
    @planners = current_user.planners
  end

  def show
    @planner = current_user.planners.find_by(id: params[:id])
    if @planner.nil?
      redirect_to planners_path
    end
  end

  private

  def correct_user
    @planner = current_user.planners.find_by(id: params[:id])
    redirect_to root_path
  end
end
