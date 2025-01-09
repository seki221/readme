class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  def oauth
    provider = auth_params[:provider]
    login_at(auth_params[:provider], auth_params.merge(provider: provider))
  end

  def callback
    provider = auth_params[:provider]

    flash_provider =
    case provider
    # when "twitter" then "X"
    when "google" then "Google"
    end

    existing_user = User.find_by(email: params[:email])

    if @user = login_from(provider)
      redirect_to root_path, success: "#{flash_provider}アカウントでログインしました"
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to root_path, success: "#{flash_provider}アカウントでログインしました"
      rescue StandardError
        if existing_user
          redirect_to root_path, danger: "#{flash_provider}アカウントでのログインに失敗しました。このメールアドレスは既に登録されています。"
        else
          redirect_to root_path, danger: "#{flash_provider}アカウントでのログインに失敗しました"
        end
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :oauth_token, :oauth_verifier)
  end

  def login_at(provider_name, args = {})
    redirect_to sorcery_login_url(provider_name, args), allow_other_host: true
  end
end