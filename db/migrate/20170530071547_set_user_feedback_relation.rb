class SetUserFeedbackRelation < ActiveRecord::Migration[5.0]
  def change
    rename_column :feedbacks, :feedbacker, :feedbacker_id
  end
end
