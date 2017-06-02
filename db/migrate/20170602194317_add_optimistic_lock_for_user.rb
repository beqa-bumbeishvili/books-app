class AddOptimisticLockForUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :lock_version, :integer, default: 0
  end
end
