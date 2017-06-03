class Feedback < ApplicationRecord
  belongs_to :book
  belongs_to :user, class_name: 'User', foreign_key: :feedbacker_id

  before_save :check_whitelist

  def check_whitelist
    self.whitelist = true
    self.whitelist = false if self.comment.include?('fuck')
  end

end
