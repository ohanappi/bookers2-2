Rails.application.routes.draw do
  devise_for :users
  root to:'homes#top'

  # get 'users' => 'users#index'
  # get "users/:id/edit" => 'users#edit', as:'edit_user'
  # get 'users/:id' => 'users#show', as:'user'
  
  resources :users
  resources :books
  


  get'home/about'=>'homes#about'
  



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
