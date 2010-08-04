require 'spec_helper'

describe Chapter do
  include ModelHelpers

  before(:each) do
    reset_db
  end

  it "should know its book" do
    c = Chapter.create!(Factory.attributes_for(:chapter))
    c.book.should be_a_kind_of(Book)
  end

  it "should create a new instance given valid attributes" do
    c = Chapter.create!(Factory.attributes_for(:chapter))
    c.type.should == nil
    c.position.should == 0  
    c.user_id.should == c.book.user_id  
  end

  def c1
    @c1 ||= SubChapter.create!(Factory.attributes_for(:sub_chapter, :parent => @parent))
    Chapter.find(@c1.id)
  end
  
  def c2
    @c2 ||= SubChapter.create!(Factory.attributes_for(:sub_chapter, :parent => @parent))
    Chapter.find(@c2.id)
  end
  
  def c3
    @c3 ||= SubChapter.create!(Factory.attributes_for(:sub_chapter, :parent => @parent))
    Chapter.find(@c3.id)
  end
  
  def c4
    @c4 ||= SubChapter.create!(Factory.attributes_for(:sub_chapter, :parent => @parent))
    Chapter.find(@c4.id)
  end

  it "should reorder the sub_chapters" do
    @book = Factory.create(:book)
    @parent = Chapter.create!(Factory.attributes_for(:chapter, :parent => @book))
    [c1, c2, c3] 
    @parent.sub_chapters(true).should == [c1, c2, c3]
    c1.position.should == 0
    c2.position.should == 1
    c3.position.should == 2
    
    @parent.shift_chapter_position(c2, "0") # middle to front
    @parent.sub_chapters(true).should == [c2, c1, c3]

    c1.position.should == 1
    c2.position.should == 0
    c3.position.should == 2
    
    @parent.shift_chapter_position(c1, "2") # middle to back
    @parent.sub_chapters(true).should == [c2, c3, c1]

    @parent.shift_chapter_position(c2, "1") # front to middle
    @parent.sub_chapters(true).should == [c3, c2, c1]

    @parent.shift_chapter_position(c3, "2") # front to back
    @parent.sub_chapters(true).should == [c2, c1, c3]

    @parent.shift_chapter_position(c3, "1") # back to middle
    @parent.sub_chapters(true).should == [c2, c3, c1]

    @parent.shift_chapter_position(c1, "0") # back to front
    @parent.sub_chapters(true).should == [c1, c2, c3]

    c1.position.should == 0
    c2.position.should == 1
    c3.position.should == 2
    c4.position.should == 3
    
    @parent.shift_chapter_position(c4, "1") 
    @parent.sub_chapters(true).should == [c1, c4, c2, c3]

    c1.position.should == 0
    c2.position.should == 2
    c3.position.should == 3
    c4.position.should == 1
  end
  
end
