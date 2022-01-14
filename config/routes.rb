Rails.application.routes.draw do
  devise_for :user, only: []

  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resource :logout, only: [:destroy], controller: :sessions
    resources :users, only: [:index, :create]
    resources :teams, only: [:index, :show, :create, :update]
    resources :reviews, only: [:index, :create]
    post 'careers', to: 'careers#create'
    post 'celebrities', to: 'celebrities#create'
    get 'bbs/comments/:id', to: 'bbs/comments#show'
    get 'bbs/forums', to: 'bbs/forums#index'
    get 'bbs/forums/:id', to: 'bbs/forums#show'
    post 'bbs/forums', to: 'bbs/forums#create'
    get 'bbs/threads/:id', to: 'bbs/threads#show'
    post 'bbs/threads', to: 'bbs/threads#create'
    get 'bbs/comments/:id', to: 'bbs/comments#show'
    post 'bbs/comments', to: 'bbs/comments#create'
    post 'bbs/reports', to: 'bbs/reports#create'
  end
end
