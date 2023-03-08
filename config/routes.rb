Rails.application.routes.draw do
  resources :posts
  resources :member_relations
  resources :profiles
  resources :reactions
  resources :comments
  resources :block_comments
  resources :groups do
    member do
      get 'members'
      get 'pending_posts'
    end
    collection do
      get 'of_friend'
    end
  end
  resources :relations do
    collection do
      get 'friends'
      get 'requests'
    end
  end
  root to: 'home#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  devise_for :admins
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  post '/posts' => 'posts#create'
  get '/not_permission' => 'home#not_permission', as: :not_permission
  get '/:token' => 'users#show', as: :user
end
