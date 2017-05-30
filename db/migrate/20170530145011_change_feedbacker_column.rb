class ChangeFeedbackerColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :feedbacks, :feedbacker_id
    add_column :feedbacks, :feedbacker_id, :integer
    add_foreign_key :feedbacks, :users, column: :feedbacker_id
  end
end
