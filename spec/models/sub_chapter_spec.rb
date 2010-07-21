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

  it "should create a new instance given valid attributes" do
    SubChapter.create!(Factory.attributes_for(:sub_chapter))
  end

end
