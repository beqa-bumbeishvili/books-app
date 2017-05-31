json.extract! address_book, :id, :name, :last_name, :phone, :email, :user_id, :created_at, :updated_at
json.url address_book_url(address_book, format: :json)
