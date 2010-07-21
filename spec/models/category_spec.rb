require 'spec_helper'

describe Category do
  include ModelHelpers

  before(:each) do
    reset_db
  end

  it "should create a new instance given valid attributes" do
    Category.create!(Factory.attributes_for(:category))
  end

  it "should fail to create given an invalid name" do
    c = Category.new(Factory.attributes_for(:category, :name => "Apostrophe's Not Allowed"))
    c.should_not be_valid
  end

  it "should fail to create given an existing name" do
    c = Factory.create(:category)
    c2 = Category.new(Factory.attributes_for(:category, :name => c.name) )
    c2.should_not be_valid
  end

end
