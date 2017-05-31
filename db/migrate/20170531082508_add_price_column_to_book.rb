class AddPriceColumnToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :price, :decimal, default: 10
  end
end
