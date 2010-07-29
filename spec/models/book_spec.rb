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
    @c1 ||= Chapter.create!(Factory.attributes_for(:chapter, :parent => @book))
    Chapter.find(@c1.id)
  end
  
  def c2
    @c2 ||= Chapter.create!(Factory.attributes_for(:chapter, :parent => @book))
    Chapter.find(@c2.id)
  end
  
  def c3
    @c3 ||= Chapter.create!(Factory.attributes_for(:chapter, :parent => @book))
    Chapter.find(@c3.id)
  end
  
  def c4
    @c4 ||= Chapter.create!(Factory.attributes_for(:chapter, :parent => @book))
    Chapter.find(@c4.id)
  end
  
  
  it "should reorder the chapters" do
    @book = Factory.create(:book)
    [c1, c2, c3] 
    @book.chapters(true).should == [c1, c2, c3]
    c1.position.should == 0
    c2.position.should == 1
    c3.position.should == 2
    
    @book.shift_chapter_position(c2.id, "0") # middle to front
    @book.chapters(true).should == [c2, c1, c3]

    c1.position.should == 1
    c2.position.should == 0
    c3.position.should == 2
    
    @book.shift_chapter_position(c1.id, "2") # middle to back
    @book.chapters(true).should == [c2, c3, c1]

    @book.shift_chapter_position(c2.id, "1") # front to middle
    @book.chapters(true).should == [c3, c2, c1]

    @book.shift_chapter_position(c3.id, "2") # front to back
    @book.chapters(true).should == [c2, c1, c3]

    @book.shift_chapter_position(c3.id, "1") # back to middle
    @book.chapters(true).should == [c2, c3, c1]

    @book.shift_chapter_position(c1.id, "0") # back to front
    @book.chapters(true).should == [c1, c2, c3]

    c1.position.should == 0
    c2.position.should == 1
    c3.position.should == 2
    c4.position.should == 3
    
    @book.shift_chapter_position(c4.id, "1") 
    @book.chapters(true).should == [c1, c4, c2, c3]

    c1.position.should == 0
    c2.position.should == 2
    c3.position.should == 3
    c4.position.should == 1
  end
  
end
