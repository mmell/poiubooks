require 'spec_helper'

describe SubChapter do
  include ModelHelpers

  before(:each) do
    reset_db
  end

  it "should know its book" do
    c = SubChapter.create!(Factory.attributes_for(:sub_chapter))
    c.book.should be_a_kind_of(Book)
  end

  it "should know its chapter" do
    c = SubChapter.create!(Factory.attributes_for(:sub_chapter))
    c.chapter.should be_a_kind_of(Chapter)
  end

  it "should create a new instance given valid attributes" do
    SubChapter.count.should == 0
    c = SubChapter.new(Factory.attributes_for(:sub_chapter))
    c.type.should == 'SubChapter'
    c.parent_type.should == 'Chapter'
    SubChapter.count.should == 0 
    
    c.position.should == nil
    c.defaults
    c.position.should == 0  
    
    c.save!
    c.position.should == 0  
    c.user_id.should == c.chapter.user_id
  end

end
