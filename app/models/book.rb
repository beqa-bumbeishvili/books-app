class Book < ApplicationRecord
  belongs_to :author #optional: true

  #before_create :set_book_number

  private

  def set_book_number
    self.update(number: "#+_+#{self.id}")
  end
end
