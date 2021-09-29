Rails.application.routes.draw do
  root 'home#top'
  get 'chats/show'
  get 'home/about'
  get 'finder' => "finders#finder"
  # get 'finders/finder'
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
  resources :groups do
    get "join" =>"groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
end
