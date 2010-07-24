class SubChapter < Chapter

  include Authoring
  belongs_to :parent, :polymorphic => true

  has_many :comments, :as => :commentable, :dependent => :destroy

  validates_format_of( :title, :with => Chapter::TitleRE )
  validates_uniqueness_of( :title, :scope => :parent_id )
  validates_presence_of( :parent_id)   
  validates_associated( :parent)    

  validates_numericality_of(:position, :minimum => 1)
  validates_uniqueness_of( :position, :scope => :parent_id )

  before_validation_on_create :defaults

  after_save :trigger_notification

  def book
    parent.parent
  end

end
