Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  
  root to: "homes#top"
  get "home/about", to: "homes#about"
  get "home/top", to: "homes#top"


  resources :books, only: [:index, :show, :edit, :create, :destroy, :update, :new] do
    resources :comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
  end

  # 1対多のDM
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]

  resources :users, only: [:index, :show, :edit, :update, :new, :create] do
    # ↓非同期の検索
    get "search" => "users#search"
  end

  # グループDM
  resources :groups, only: [:new, :index, :show, :create, :edit, :update]

  # フォローフォロワー
    # ネストさせる
    resources :users do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end