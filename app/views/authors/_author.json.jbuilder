json.extract! author, :id, :number, :name, :last_name, :birth_date, :address_id, :created_at, :updated_at
json.url author_url(author, format: :json)
