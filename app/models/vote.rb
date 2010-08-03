class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment

  validates_uniqueness_of( :comment_id, :scope => :user_id )
  validate :voter_is_not_commenter
  
  def voter_is_not_commenter()
    errors.add_to_base("You can't vote on your own comments.") if user_id == comment.user_id
  end
          
end
