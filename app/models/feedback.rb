class Feedback < ApplicationRecord
  belongs_to :book
  belongs_to :user, class_name: 'User', foreign_key: :feedbacker_id
end
