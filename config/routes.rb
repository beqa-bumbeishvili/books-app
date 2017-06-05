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
  get '/user_address_book' => 'address_books#user_address_book', as: :user_address_book
  post '/user_address_book' => 'address_books#user_address_book'
  get  '/bad_feedbacks' => 'feedbacks#bad_feedback', as: :bad_feedbacks

  get '/feedbacks/:id/change_feedback_status(.:format)' => 'feedbacks#change_feedback_status', as: :change_feedback_status

  root 'authors#index'
end
