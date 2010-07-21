require 'spec_helper'

describe "/users/new.html.erb" do
  include UsersHelper

  before(:each) do
    assigns[:user] = stub_model(User,
      :new_record? => true,
      :name => "value for name",
      :email => "value for email",
      :image => "value for image",
      :description => "value for description",
      :is_admin => false
    )
  end

  it "renders new user form" do
    render

    response.should have_tag("form[action=?][method=post]", users_path) do
      with_tag("input#user_name[name=?]", "user[name]")
      with_tag("input#user_email[name=?]", "user[email]")
      with_tag("input#user_image[name=?]", "user[image]")
      with_tag("textarea#user_description[name=?]", "user[description]")
      with_tag("input#user_is_admin[name=?]", "user[is_admin]")
    end
  end
end
