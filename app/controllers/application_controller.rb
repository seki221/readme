class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  def set_search
    @q = Schedule.ransack(params[:q])
    @schedules = @q.result(distinct: true)
  end
end
