Rails.application.routes.draw do
  devise_for :user, only: []

  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resources :users, only: [:index, :create]
    resources :teams, only: [:index, :show, :create, :update]
  end
end
