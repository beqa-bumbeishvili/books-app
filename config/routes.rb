Rails.application.routes.draw do
  resources :address_books
  resources :users
  resources :books
  resources :authors
  resources :addresses
  resources :feedbacks

  get 'two_books_author' => 'authors#two_books_author'
  post 'create_two_books_author' => 'authors#create_author_two_books'
  get 'book_filter_view' => 'authors#book_filter_view'

  root 'authors#index'
end
