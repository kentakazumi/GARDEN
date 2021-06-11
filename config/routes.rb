Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
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

end
