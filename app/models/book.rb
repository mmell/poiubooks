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

  after_update :send_book_notification

  def send_book_notification()
    self.notifications.each { |e| 
      BookMailer.deliver_book_notification(e.user, self, e)
    }
  end
  private :send_book_notification
  
  def send_chapter_notification(chapter)
    self.notifications.each { |e| 
      BookMailer.deliver_book_notification(e.user, self, chapter, e)
    }
  end

  def send_comment_notification(comment)
    if self == comment.commentable 
      BookMailer.deliver_book_notification(owner, self, comment)
    else
      BookMailer.deliver_chapter_comment_notification(owner, self, comment) 
    end
  end

end
