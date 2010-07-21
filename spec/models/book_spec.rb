require 'spec_helper'

describe Book do
  include ModelHelpers

  before(:each) do
    reset_db
  end

  it "should fail to create given an invalid title" do
    b = Book.new(Factory.attributes_for(:book, :title => "Star* Not Allowed"))
    b.should_not be_valid
  end

  it "should fail to create given an existing title the same user" do
    b = Factory.create(:book)
    b2 = Book.new(Factory.attributes_for(:book, :user => b.user, :title => b.title) )
    b2.should_not be_valid
    b2.user = Factory.create(:user)
    b2.should be_valid
  end

  it "should create a new instance given valid attributes" do
    Book.create!(Factory.attributes_for(:book))
  end

end
