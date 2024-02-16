Rails.application.routes.draw do
  require 'resque/server'
  mount Resque::Server, at: '/jobs'

  patch 'invites/:id', to: 'invites#update', as: 'invite'

  get 'cart/add/:id', to: 'carts#add', as: 'cart_add'

  resources :products

  post 'support/request_support'

  resources :poly_comments
  resources :comments, only: [:edit, :update]

  resources :pins do
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
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
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
