class User < ApplicationRecord

  self.locking_column = :lock_version

  has_many :feedbacks

  def name_and_lastname
    "#{self.name} #{self.last_name}"
  end
end
