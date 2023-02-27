Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]

  root 'posts#index'

  get 'posts/ranking' => 'posts#ranking'
  get 'posts/random' => 'posts#random'
  
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :bats, only: [:create, :destroy]
    resources :comments do
      resources :outs, only: [:create, :destroy]
    end
  end
  resources :tags do
    get 'posts', to: 'posts#search'
  end
end


