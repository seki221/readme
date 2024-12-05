class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
  before_action :debug_current_user

  private
  def require_login
    unless current_user
      redirect_to login_path, alert: 'ログインが必要です。'
    end
  end

  def debug_current_user
    Rails.logger.debug "Current User: #{current_user.inspect}"
  end


  def configure_permitted_parameters
    if resource_class == User
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :password])
      devise_parameter_sanitizer.permit(:sign_in,keys:[:email, :password])
      devise_parameter_sanitizer.permit(:account_update,keys:[:nickname, :email, :password, :current_password])
    end
  end

  def set_search
    @q = Schedule.ransack(params[:q])
    @schedules = @q.result(distinct: true)
  end
end
