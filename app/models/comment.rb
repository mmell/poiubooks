class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true, :touch => true
  
  validates_presence_of( :commentable)   
  validates_associated( :commentable)    

  validates_numericality_of(:vote, :only_integer => true, :allow_nil => true, :less_than_or_equal_to => 5 )
  validates_length_of( :content, :minimum => 2 )
end
