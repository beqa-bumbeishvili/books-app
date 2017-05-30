class User < ApplicationRecord

  has_many :feedbacks

  def name_and_lastname
    "#{self.name} #{self.last_name}"
  end
end
