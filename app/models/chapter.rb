class Chapter < ActiveRecord::Base
  
  include Authoring
  
  TitleRE = %r{\A[\w 0-9'",-]{2,}\z}
  
  belongs_to :user
  belongs_to :parent, :polymorphic => true
  
  has_many :sub_chapters, :as => :parent, :dependent => :destroy, :order => :position
  has_many :comments, :as => :commentable, :dependent => :destroy, :order => 'created_at'

  validates_format_of( :title, :with => TitleRE )
  validates_uniqueness_of( :title, :scope => :parent_id )
  validates_presence_of( :user_id, :parent_id)
  validates_associated( :user, :parent)

  validates_numericality_of(:position)
  validates_uniqueness_of( :position, :scope => [:parent_id, :parent_type] )
  
  before_validation_on_create :defaults

  after_save :trigger_notification
  
  attr_protected :user_id, :parent_id
  
  validate :kind_of_parent
  
  def kind_of_parent
    errors.add(:parent, "parent must be a Book.") unless parent.is_a?(Book)
  end

  def defaults
    self.position = Chapter.count( :conditions => "parent_id=#{parent.id}" )
    self.user = parent.user
  end
  
  def book
    parent
  end
    
  def full_title
    "#{book.title}/#{title}"
  end

  def trigger_notification()
    book.send_chapter_notifications(self)
  end
  
  def shift_chapter_position(moving_sub_chapter, move_to)
    children = self.sub_chapters.dup
    children.delete(moving_sub_chapter)
    children.insert(move_to.to_i, moving_sub_chapter)
    children.each_index { |ix|
      children[ix].update_attribute( :position, ix)
    }
  end

end
