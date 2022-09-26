Rails.application.routes.draw do
  devise_for :user, only: []

  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resource :organizer, only: [:create], controller: :organizers do 
      collection do
        post 'login', action: :create, controller: :sessions
        post 'logout', action: :destroy, controller: :sessions
        post 'apply', action: :apply, controller: :organizers
        post 'reset', action: :reset, controller: :organizers
      end
      resource :users do
        member do
          get ':id', action: :show, controller: :organizers
          patch ':id/:target', action: :update, controller: :organizers
        end
      end
      resource :manage do
        collection do
          get 'reports', action: :reports, controller: :organizers
          get 'withdrawals', action: :withdrawals, controller: :organizers
          get 'request_withdrawals', action: :request_withdrawals, controller: :organizers
          post 'withdrawals', action: :create_withdrawals, controller: :organizers
        end
      end
    end
    resource :logout, only: [:destroy], controller: :sessions
    resources :users, only: [:index, :create, :show, :update]
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
        patch 'purchase', to: 'funds#delete_purchase'
      end
    end
    resources :lessons, only: [:index, :show, :create, :update]
    resources :talks, except: [:update] do
      collection do
        post ':id/comment',  to: 'talks#create_comment'
        patch ':id/comment/payment',  to: 'talks#payment_status'
        patch ':id/comment/payment/cancel',  to: 'talks#cancel_status'
      end
    end
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
        get 'lessons',  to: 'lessons#manage_index'
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
    post 'payment/plan', to: 'payment#plan'
    post 'payment/customer', to: 'payment#create_customer'
    post 'payment/cancel', to: 'payment#cancel'
    get 'payment/api_confirm', to: 'payment#api_confirm'
  end
end
