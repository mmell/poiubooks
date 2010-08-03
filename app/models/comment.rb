class Comment < ActiveRecord::Base

  include Authoring
  
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  
  has_many :votes, :dependent => :destroy

  validates_presence_of( :commentable)   
  validates_associated( :commentable)    

  validates_length_of( :content, :minimum => 2 )
  
  attr_protected :user_id

  after_save :trigger_notification
  
  def book
    case commentable_type
    when 'Book'
      commentable
    when 'Chapter'
      commentable.book
    end
  end
  
  def trigger_notification()
    book.send_comment_notification(self)
  end
  
  def anchor
    "comment_#{self.id}"
  end
  
  def count_vote_by_group
    @count_votes ||= Vote.count(:conditions => "comment_id=#{self.id}", :group => 'vote')
  end

  def count_votes
    count_vote_by_group[true].to_i + count_vote_by_group[false].to_i
  end

end
