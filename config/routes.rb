Rails.application.routes.draw do
  devise_for :user, only: []

  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resource :logout, only: [:destroy], controller: :sessions
    resources :users, only: [:index, :create]
    resources :teams, only: [:index, :show, :create, :update]
    resources :reviews, only: [:index, :create]
  end
end
