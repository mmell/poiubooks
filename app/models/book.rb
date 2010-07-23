class Book < ActiveRecord::Base 

  include Authoring
  
  belongs_to :user
  belongs_to :category
  belongs_to :license
  
  has_many :chapters, :as => :parent, :dependent => :destroy, :order => :position
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  
  validates_format_of( :title, :with => %r{\A[\w 0-9',-]{2,}\z} )
  validates_uniqueness_of( :title, :scope => :user_id )
  validates_presence_of( :user_id, :category_id, :license_id)   
  validates_associated( :user, :category, :license)    
  validates_length_of(:terms, :minimum => 2)
   
  attr_protected :user_id

#  after_update :trigger_notification

#  def trigger_notification(obj = self)
#    send_notification(obj)
#  end
  
#  def send_notification(obj)
#    raise NotImplementedError
#  end
  
end
