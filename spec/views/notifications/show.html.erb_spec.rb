require 'spec_helper'

describe "/notifications/show.html.erb" do
  include NotificationsHelper
  before(:each) do
    assigns[:notification] = @notification = stub_model(Notification,
      :user_id => 1,
      :book_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
  end
end
