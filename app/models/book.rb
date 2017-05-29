class Book < ApplicationRecord
  belongs_to :author
  has_many :feedbacks

  #before_create :set_book_number

  private

  def set_book_number
    self.update(number: "#+_+#{self.id}")
  end
end
