Rails.application.routes.draw do
  resources :galleries do
    resources :gallery_images, only: :create
  end

  resources :gallery_images, only: :destroy do
    member do
      get :lower
      get :higher
    end
  end

  resources :notifications
  resources :attachments
  require 'resque/server'
  mount Resque::Server, at: '/jobs'

  patch 'invites/:id', to: 'invites#update', as: 'invite'

  get 'cart/add/:id', to: 'carts#add', as: 'cart_add'

  resources :products

  post 'support/request_support'

  resources :poly_comments
  resources :comments, only: [:edit, :update]

  resources :pins do
    member do
      get 'toggle_favourite', to: 'pins#toggle_favourite', as: 'toggle_favourite'
      get 'toggle_like', to: 'pins#toggle_like', as: 'toggle_like'
    end

    resources :comments
    get "/by_tag/:tag", to: "pins#by_tag", on: :collection, as: "tagged"
  end

  resources :posts

  devise_for :users, controllers: { registrations: 'registrations' }

  # devise_for :users, path: '', path_names: {
  #   sign_in: 'login',
  #   sign_out: 'logout',
  #   registration: 'signup'
  # },
  # controllers: {
  #   sessions: 'users/sessions',
  #   registrations: 'users/registrations'
  # }

  namespace :api do
    namespace :v1 do
      resources :pins

      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        post "sign_out", to: "sessions#destroy"
      end
    end
  end

  resources :profiles, only: [:show, :edit, :update]

  # resources :pins do
  #   resources :comments, except: :show
  # end

  resources :subscriptions, only: [:create, :show]

  get 'welcome/index'
  get 'welcome/about'
  get 'welcome/feed'
  get 'welcome/search'
  get 'welcome/speech'

  root "welcome#index"

  namespace :admin do
    resources :pins do
      resources :comments, except: :show
    end

    resources :comments
    resources :subscriptions

    root "admin/pins#index"
  end
end
