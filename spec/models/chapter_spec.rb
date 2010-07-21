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
    Chapter.create!(Factory.attributes_for(:chapter))
  end

end
