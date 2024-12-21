Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'planners#index'

  resources :planners, only: %i[index new create show edit update destroy] do
    resources :schedules, only: %i[index new create show edit update destroy] do
    end
  end
end
