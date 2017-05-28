class ChangeAddressAuthorRelation < ActiveRecord::Migration[5.0]
  def change
    remove_column :authors, :address_id
    add_column :addresses, :author_id, :integer
    add_foreign_key :addresses, :authors
  end
end
