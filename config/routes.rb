Rails.application.routes.draw do
  get 'finders/finder'
  root 'home#top'
  get 'home/about'
  get 'finder' => "finders#finder"
  devise_for :users
  resources :travels do 
    collection do 
      delete 'destroy_all'
    end
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
