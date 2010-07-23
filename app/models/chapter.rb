class Chapter < ActiveRecord::Base
  
  include Authoring
  
  TitleRE = %r{\A[\w 0-9'",-]{2,}\z}
  
  belongs_to :user
  belongs_to :parent, :polymorphic => true
  
  has_many :sub_chapters, :as => :parent, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  validates_format_of( :title, :with => TitleRE )
  validates_uniqueness_of( :title, :scope => :parent_id )
  validates_presence_of( :user_id, :parent_id)   
  validates_associated( :user, :parent)    

  validates_numericality_of(:position, :minimum => 1)
  validates_uniqueness_of( :position, :scope => :parent_id )
  
  before_validation_on_create :defaults

  attr_protected :user_id

  def defaults
    self.position = Chapter.count_by_sql(
      "select count(*) from chapters where parent_type='Book' and parent_id=#{book.id}"
    )
  end
  
  def book
    parent
  end
  
#  after_save :trigger_notification
  
#  def trigger_notification(obj = self)
#    parent.trigger_notification(obj)
#  end
  
end
