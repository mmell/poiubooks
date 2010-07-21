require 'spec_helper'

describe "/users/index.html.erb" do
  include UsersHelper

  before(:each) do
    assigns[:users] = [
      stub_model(User,
        :name => "value for name",
        :email => "value for email",
        :image => "value for image",
        :description => "value for description",
        :is_admin => false
      ),
      stub_model(User,
        :name => "value for name",
        :email => "value for email",
        :image => "value for image",
        :description => "value for description",
        :is_admin => false
      )
    ]
  end

  it "renders a list of users" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for email".to_s, 2)
    response.should have_tag("tr>td", "value for image".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
    response.should have_tag("tr>td", false.to_s, 2)
  end
end
