Rails.application.routes.draw do
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

  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :pins
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
