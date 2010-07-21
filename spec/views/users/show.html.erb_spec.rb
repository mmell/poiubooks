require 'spec_helper'

describe "/users/show.html.erb" do
  include UsersHelper
  before(:each) do
    assigns[:user] = @user = stub_model(User,
      :name => "value for name",
      :email => Factory.next(:email),
#      :image => "value for image",
      :description => "value for description",
      :is_admin => false
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/@example.com/)
#    response.should have_text(/value\ for\ image/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/false/)
  end
end
