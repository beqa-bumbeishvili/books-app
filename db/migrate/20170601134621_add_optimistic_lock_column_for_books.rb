class AddOptimisticLockColumnForBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :lock_increment, :integer, default: 0
  end
end
