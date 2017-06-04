class User < ApplicationRecord

  self.locking_column = :lock_version

  has_many :feedbacks, foreign_key: :feedbacker_id,  dependent: :destroy

  has_many :address_books, dependent: :destroy


  def name_and_lastname
    "#{self.name} #{self.last_name}"
  end
end
