Rails.application.routes.draw do
  get 'search/search'
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
  get '/search' => 'search#search'
  resources :post_images do
   resource :favorites, only: [:create, :destroy]
   resources :comments, only: [:create, :destroy]
  end
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  resources :users do
    get 'followsings' => 'relationships#follows'
    get 'followers' => 'relationships#followers'
  end
  post 'post_images/search' => 'post_images#search'

  resources :notifications, only: [:index, :destroy]
  delete 'destroy_all_users_notifications'=> 'notifications#destroy_all', as: 'destroy_all_users_notifications'
end
