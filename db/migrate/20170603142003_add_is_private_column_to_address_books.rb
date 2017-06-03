class AddIsPrivateColumnToAddressBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :address_books, :is_private, :boolean, default: false
  end
end
