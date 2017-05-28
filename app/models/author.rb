class Author < ApplicationRecord
  has_one :address

  has_many :books, inverse_of: :author, dependent: :destroy

  accepts_nested_attributes_for :books, reject_if: proc { |book| book['title'].blank?}

  after_create :set_author_number

  def name_and_lastname
    "#{self.name} #{self.last_name}"
  end

  def set_author_number
    Author.where(id: self.id).update(number: "#_#{self.id}")
  end

end
