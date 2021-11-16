Rails.application.routes.draw do
  devise_for :user, only: []

  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resource :logout, only: [:destroy], controller: :sessions
    resources :users, only: [:index, :create]
    resources :teams, only: [:index, :show, :create, :update]
    resources :reviews, only: [:index, :create]
    get 'bbs/forums', to: 'bbs/forums#index'
    post 'bbs/forums', to: 'bbs/forums#create'
    get 'bbs/threads/:id', to: 'bbs/threads#show'
    post 'bbs/threads', to: 'bbs/threads#create'
    get 'bbs/comments/:id', to: 'bbs/alerts#show'
    post 'bbs/comments', to: 'bbs/alerts#create'
    post 'bbs/alerts', to: 'bbs/alerts#create'
  end
end
