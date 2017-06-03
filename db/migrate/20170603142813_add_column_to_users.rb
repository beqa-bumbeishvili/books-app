class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :private_address_count, :integer, default: 0
  end
end
