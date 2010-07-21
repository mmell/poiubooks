require 'spec_helper'

describe "/users/edit.html.erb" do
  include UsersHelper

  before(:each) do
    assigns[:user] = @user = stub_model(User, Factory.attributes_for(:user) )
  end

  it "renders the edit user form" do
    render

    response.should have_tag("form[action=#{users_path(@user)}][method=post]") do
      with_tag('input#user_name[name=?]', "user[name]")
      with_tag('input#user_email[name=?]', "user[email]")
      with_tag('input#user_image[name=?]', "user[image]")
      with_tag('textarea#user_description[name=?]', "user[description]")
      with_tag('input#user_is_admin[name=?]', "user[is_admin]")
    end
  end
end
