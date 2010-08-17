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
  
  it "should order rss_channels by modification" do
    b = Factory.create(:book) 
    b.rss_channels.should == []
    c1 = Chapter.create!(Factory.attributes_for(:chapter, :parent => b, :updated_at => 1.day.ago))
    b.rss_channels(true).should == [c1]
    c2 = Chapter.create!(Factory.attributes_for(:chapter, :parent => b))
    b.rss_channels(true).should == [c2, c1]
    c1.update_attributes(:updated_at => 1.day.from_now)
    b.rss_channels(true).should == [c1, c2]
  end
  
  def c1
    @c1 ||= Chapter.create!(Factory.attributes_for(:chapter, :parent => @parent))
    Chapter.find(@c1.id)
  end
  
  def c2
    @c2 ||= Chapter.create!(Factory.attributes_for(:chapter, :parent => @parent))
    Chapter.find(@c2.id)
  end
  
  def c3
    @c3 ||= Chapter.create!(Factory.attributes_for(:chapter, :parent => @parent))
    Chapter.find(@c3.id)
  end
  
  def c4
    @c4 ||= Chapter.create!(Factory.attributes_for(:chapter, :parent => @parent))
    Chapter.find(@c4.id)
  end
    
  it "should reorder the chapters" do
    @parent = Factory.create(:book)
    [c1, c2, c3] 
    @parent.chapters(true).should == [c1, c2, c3]
    c1.position.should == 1
    c2.position.should == 2
    c3.position.should == 3
    
    @parent.shift_chapter_position(c2, "1") # middle to front
    @parent.chapters(true).should == [c2, c1, c3]

    c1.position.should == 2
    c2.position.should == 1
    c3.position.should == 3
    
    @parent.shift_chapter_position(c1, "3") # middle to back
    @parent.chapters(true).should == [c2, c3, c1]

    @parent.shift_chapter_position(c2, "2") # front to middle
    @parent.chapters(true).should == [c3, c2, c1]

    @parent.shift_chapter_position(c3, "3") # front to back
    @parent.chapters(true).should == [c2, c1, c3]

    @parent.shift_chapter_position(c3, "2") # back to middle
    @parent.chapters(true).should == [c2, c3, c1]

    @parent.shift_chapter_position(c1, "1") # back to front
    @parent.chapters(true).should == [c1, c2, c3]

    c1.position.should == 1
    c2.position.should == 2
    c3.position.should == 3
    c4.position.should == 4
    
    @parent.shift_chapter_position(c4, "2") 
    @parent.chapters(true).should == [c1, c4, c2, c3]

    c1.position.should == 1
    c2.position.should == 3
    c3.position.should == 4
    c4.position.should == 2
  end
  
end
