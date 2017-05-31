class CreateAddressBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :address_books do |t|
      t.string :name
      t.string :last_name
      t.string :phone
      t.string :email
      t.references :user, foreign_key: true
    end
    add_index :address_books, [:id, :user_id], unique: true
  end
end
