require 'spec_helper'

describe "/notifications/index.html.erb" do
  include NotificationsHelper

  before(:each) do
    assigns[:notifications] = [
      stub_model(Notification,
        :user_id => 1,
        :book_id => 1
      ),
      stub_model(Notification,
        :user_id => 1,
        :book_id => 1
      )
    ]
  end

  it "renders a list of notifications" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
