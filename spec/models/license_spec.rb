require 'spec_helper'

describe License do
  include ModelHelpers

  before(:each) do
    reset_db
  end

  it "should create a new instance given valid attributes" do
    License.create!(Factory.attributes_for(:license))
  end

  it "should fail to create given an invalid url" do
    c = License.new(Factory.attributes_for(:license, :url => "bad://httpexample"))
    c.should_not be_valid
  end

  it "should fail to create given an existing url" do
    c = Factory.create(:license)
    c2 = License.new(Factory.attributes_for(:license, :url => c.url) )
    c2.should_not be_valid
  end

end
