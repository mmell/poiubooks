require 'spec_helper'

describe Notification do
  include ModelHelpers

  before(:each) do
    reset_db
  end

  it "should create a new instance given valid attributes" do
    Notification.create!(Factory.attributes_for(:notification))
  end
end
