class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  attr_protected :user_id

end
