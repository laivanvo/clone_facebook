Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
  end

  mount ActionCable.server => "/cable"

  resources :posts
  resources :member_relations
  resources :profiles
  resources :reactions
  resources :comments
  resources :block_comments
  resources :notifications do
    member do
      patch "view"
    end
    collection do
      patch "view_all"
    end
  end
  resources :search do
    collection do
      get "friend"
      get "recommend_user"
      get "home_post"
      get "recommend_post"
      get "joined_group"
      get "recommend_group"
    end
  end
  resources :groups do
    member do
      get "members"
      get "pending_posts"
    end
    collection do
      get "of_friend"
    end
  end
  resources :relations do
    collection do
      get "friends"
      get "requests"
    end
  end
  root to: "home#index"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations" }
  devise_for :admins
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  post "/posts" => "posts#create"
  get "/not_permission" => "home#not_permission", as: :not_permission
  get "/:token" => "users#show", as: :user
end
