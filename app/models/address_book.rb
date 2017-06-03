class AddressBook < ApplicationRecord
  belongs_to :user

  after_create :increase_private_address_count

  before_update :change_private_address_count

  before_destroy :decrease_private_address_count

  def increase_private_address_count
    if self.is_private
      user = User.find(self.user_id)
      user.private_address_count += 1
      user.save!
    end
  end

  def change_private_address_count
    if self.is_private && !AddressBook.find(self.id).is_private
      user = User.find(self.user_id)
      user.private_address_count += 1
    elsif  !self.is_private && AddressBook.find(self.id).is_private
      user = User.find(self.user_id)
      user.private_address_count -= 1
    end
    user.save!
  end

  def decrease_private_address_count
    if self.is_private
      user = User.find(self.user_id)
      user.private_address_count -= 1
      user.save!
    end
  end

end
