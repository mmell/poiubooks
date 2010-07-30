class Chapter < ActiveRecord::Base
  
  include Authoring
  
  TitleRE = %r{\A[\w 0-9'",-]{2,}\z}
  
  belongs_to :user
  belongs_to :book
  
  has_many :comments, :as => :commentable, :dependent => :destroy, :order => 'created_at'

  validates_format_of( :title, :with => TitleRE )
  validates_uniqueness_of( :title, :scope => :book_id )
  validates_presence_of( :user_id, :book_id)
  validates_associated( :user, :book)

  validates_numericality_of(:position)
  validates_uniqueness_of( :position, :scope => :book_id )
  
  before_validation_on_create :defaults

  after_save :trigger_notification
  
  attr_protected :user_id, :book_id

  def defaults
    self.position = Chapter.count_by_sql(
      "select count(*) from chapters where book_id=#{book.id}"
    )
    self.user = book.user
  end
  
  def trigger_notification()
    book.send_chapter_notifications(self)
  end
  
end
