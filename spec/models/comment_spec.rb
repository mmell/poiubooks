require 'spec_helper'

describe Comment do
  include ModelHelpers

  before(:each) do
    reset_db
  end

  it "should create a new instance given valid attributes" do
    Comment.create!(Factory.attributes_for(:comment))
  end

end
