Rails.application.routes.draw do
  devise_for :user, only: []

  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resource :logout, only: [:destroy], controller: :sessions
    resources :users, only: [:index, :create, :show]
    resources :teams, only: [:index, :show, :create, :update]
    resources :reviews, only: [:index, :create]
    resources :salons do
      collection do
        post 'participate'
        patch 'participate', to: 'salons#cancel'
      end
    end
    resources :funds do
      collection do
        post 'purchase'
      end
    end
    get 'lessons', to: 'matchings#index'
    get 'lessons/:id', to: 'matchings#show'
    post 'lessons', to: 'matchings#create'
    patch 'lessons/:id', to: 'matchings#update'
    resources :matchings, only: [:index, :show, :create, :update]
    resource :manage do
      collection do
        get 'salons',  to: 'salons#manage_index'
        post 'salons/approval'
      end
      collection do
        get 'funds',  to: 'funds#manage_index'
        post 'funds/approval'
      end
      collection do
        get 'lessons',  to: 'matchings#manage_index'
        post 'lessons/approval'
      end
    end
    post 'teams/favorite', to: 'teams#favorite'
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
    post 'payment', to: 'payment#pay'
  end
end
