class SetUserFeedbackRelation < ActiveRecord::Migration[5.0]
  def change
    rename_column :feedbacks, :feedbacker, :feedbacker_id
    change_column :feedbacks, :feedbacker_id, :integer
    add_foreign_key :users, :feedbacks, column: :feedbacker_id
  end
end
