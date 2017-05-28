class Author < ApplicationRecord
  belongs_to :address

  has_many :books, inverse_of: :author, dependent: :destroy

  accepts_nested_attributes_for :books

  after_create :set_author_number

  def name_and_lastname
    "#{self.name} #{self.last_name}"
  end

  def set_author_number
    Author.where(id: self.id).update(number: "#_#{self.id}")
  end

end
