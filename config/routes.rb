Rails.application.routes.draw do
  devise_for :users
  root to: 'schedules#index'
  resources :schedules, only: %i[index new create show edit update destroy favorite] do
    resources :comments, only: %i[update create edit destroy], shallow: true
    collection do
      get :favorite
      get 'search'
    end
  end
  
  resources :favorite, only: %i[create destroy], shallow: true
end
