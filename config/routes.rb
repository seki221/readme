Rails.application.routes.draw do
  root to: 'home#top'
  
  # davise関係
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    get '/users/sign_in'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # OAuthログイン関連
  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider


  # 管理者関連
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  namespace :admin do
    root "dashboards#index"
    resources :dashboard, only: %i[index]
    get 'login' => 'user_sessions#new', :as => :login
    post 'login' => "user_sessions#create"
    delete 'logout' => 'user_sessions#destroy', :as => :logout
    resources :users, only: %i[index edit update destroy] do
    end
  end

  # planページ
  resources :planners, only: %i[index new create show edit update destroy] do
    resources :schedules, only: %i[index new create show edit update destroy] do
    end
  end
end
