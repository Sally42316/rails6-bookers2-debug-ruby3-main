Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  
  root to: "homes#top"
  get "home/about", to: "homes#about"
  get "home/top", to: "homes#top"


  resources :books, only: [:index, :show, :edit, :create, :destroy, :update, :new] do
    resources :comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update, :new, :create] do
    # ↓非同期の検索
    get "search" => "users#search"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end