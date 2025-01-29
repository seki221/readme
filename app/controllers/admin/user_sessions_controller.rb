class Admin::UserSessionsController < Admin::BaseController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_admin, only: %i[new create]
  layout 'admin_login'

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
end
