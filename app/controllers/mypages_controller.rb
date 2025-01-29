class MypagesController < ApplicationController
  before_action :authenticate_user! 
  before_action :correct_user, only: %i[index show edit update destroy]

  def show
    @planners = current_user.planners

  end

  private

  def correct_user
    @planner = current_user.planners.find_by(id: params[:id])
    redirect_to root_path, alert: "権限がありません" unless current_user
  end
end
