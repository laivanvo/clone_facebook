Rails.application.routes.draw do
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'home#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_for :admins

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  post '/posts' => 'posts#create'
end
