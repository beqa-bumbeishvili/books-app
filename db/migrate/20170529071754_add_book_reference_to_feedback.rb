class AddBookReferenceToFeedback < ActiveRecord::Migration[5.0]
  def change
    add_column :feedbacks, :book_id, :integer
    add_foreign_key :feedbacks, :books, column: :book_id
  end
end
