# frozen_string_literal: true

module Admin
  class UserSessionsController < Admin::BaseController
    before_action :require_login, only: %i[new create]
    before_action :check_admin, only: %i[new create]
    layout 'admin_login'
    def new; end

    def create
      if (@user = login(params[:email], params[:password]))
        redirect_to admin_root_path, notice: t('.success')
      else
        flash.now[:alert] = t('.failure')
        render :new
      end
    end

    def destroy
      logout
      redirect_to admin_login_path, notice: t('.logout_success')
    end

    # before_action :configure_sign_in_params, only: [:create]
    # skip_before_action :require_login, only: %i[new create]
    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
    private

    def require_login
      # ログインチェックの実装例
      redirect_to login_path unless logged_in?
    end
  end
end
