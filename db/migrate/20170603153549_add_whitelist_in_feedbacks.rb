class AddWhitelistInFeedbacks < ActiveRecord::Migration[5.0]
  def change
    add_column :feedbacks, :whitelist, :boolean, default: false
  end
end
