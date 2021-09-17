Rails.application.routes.draw do
  get 'chats/show'
  get 'finders/finder'
  root 'home#top'
  get 'home/about'
  get 'finder' => "finders#finder"
  devise_for :users
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
    collection do
      delete 'destroy_all'
    end
  end
  resources :users do
    member do
     get 'following'
     get 'follower'
    end
  end
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  resources :chats, only: [:create, :show]
end
