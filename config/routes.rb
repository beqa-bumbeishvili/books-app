Rails.application.routes.draw do
  resources :books
  resources :authors
  resources :addresses

  root 'authors#index'
end
