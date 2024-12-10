Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'schedules#index'
  resources :schedules, only: %i[index new create show edit update destroy] do
    resources :comments, only: %i[update create edit destroy], shallow: true
    collection do
      get :favorite
      get 'search'
    end
    resources :reviews, only: [:create]
        member do
      get :next_step
    end
  end
  

  get '/dates/:date', to: 'dates#show', as: 'date_show'

  resources :favorite, only: %i[create destroy], shallow: true
end
