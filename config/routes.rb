Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  devise_scope :user do
    # post "oauth/callback", to: "oauths#callback"
    # get "oauth/callback", to: "oauths#callback"
    # get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
    # delete '/users/sign_out' => 'devise/sessions#destroy'
    get '/users/sign_in'
    # post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'planners#index'

  resources :planners, only: %i[index new create show edit update destroy] do
    resources :schedules, only: %i[index new create show edit update destroy] do
    end
  end
end
