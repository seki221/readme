# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
  # before_action :require_login

  private

  # def require_login
  #   unless user_signed_in?
  #     redirect_to login_path, alert: 'ログインが必要です。'
  #   end
  # end

  def configure_permitted_parameters
    return unless resource_class == User

    devise_parameter_sanitizer.permit(:sign_up, keys: %i[nickname email password])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[nickname email password current_password])
  end

  def set_search
    @q = Schedule.ransack(params[:q])
    @schedules = @q.result(distinct: true)
  end
end
