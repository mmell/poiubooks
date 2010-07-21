require 'spec_helper'

describe User do
  before(:each) do
    [ Book, Category, Chapter, Comment, Notification, User ].each { |e| 
      e.delete_all
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(Factory.attributes_for(:user))
  end

  it "should fail to create given an invalid email" do
    user = Factory.build(:user, { :email => 'bad email' } )
    user.valid?.should_not == true
    user.email = Factory.next(:email)
    user.should be_valid
  end

  it "should enforce unique name" do
    existing_user = Factory.create(:user )
    user = Factory.build(:user, { :name => existing_user.name } )
    user.should_not be_valid
    user.name = Factory.next(:name)
    user.should be_valid
  end

end
