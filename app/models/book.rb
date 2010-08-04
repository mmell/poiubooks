class Book < ActiveRecord::Base 

  include Authoring
  
  belongs_to :user
  belongs_to :category
  belongs_to :license
  
  has_many :chapters, :as => :parent, :dependent => :destroy, :order => :position
  has_many :rss_channels, :class_name => 'Chapter', :as => :parent, :order => 'updated_at desc'
  has_many :comments, :as => :commentable, :dependent => :destroy, :order => 'created_at'
  has_many :notifications, :dependent => :destroy
  
  validates_format_of( :title, :with => %r{\A[\w 0-9',-]{2,}\z} )
  validates_uniqueness_of( :title, :scope => :user_id )
  validates_presence_of( :user_id, :category_id, :license_id)   
  validates_associated( :user, :category, :license)    
  validates_length_of(:terms, :minimum => 2)
   
  attr_protected :user_id

  after_update :send_book_notifications

  def full_title
    title
  end
  
  def send_book_notifications()
    self.notifications.each { |e| 
      BookMailer.deliver_book_notification(e.user, self)
    }
  end
  private :send_book_notifications
  
  def send_chapter_notifications(chapter)
    self.notifications.each { |e| 
      BookMailer.deliver_chapter_notification(e.user, chapter)
    }
  end

  def send_comment_notification(comment)
    if comment.commentable.is_a?(Book) 
      BookMailer.deliver_book_comment_notification(comment.commentable, comment)
    else
      BookMailer.deliver_chapter_comment_notification(comment.commentable.book, comment) 
    end
  end

  def shift_chapter_position(moving_chapter, move_to)
    children = self.chapters.dup
    children.delete(moving_chapter)
    children.insert(move_to.to_i, moving_chapter)
    children.each_index { |ix|
      children[ix].update_attribute( :position, ix)
    }
  end

end
