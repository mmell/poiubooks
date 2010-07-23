class Comment < ActiveRecord::Base

  include Authoring
  
  belongs_to :user
  belongs_to :commentable, :polymorphic => true, :touch => true
  
  validates_presence_of( :commentable)   
  validates_associated( :commentable)    

  validates_length_of( :content, :minimum => 2 )
  
  attr_protected :user_id
end
