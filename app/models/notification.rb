class Notification < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  belongs_to :book, :dependent => :destroy
end
