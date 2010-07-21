require 'spec_helper'

describe "/notifications/new.html.erb" do
  include NotificationsHelper

  before(:each) do
    assigns[:notification] = stub_model(Notification,
      :new_record? => true,
      :user_id => 1,
      :book_id => 1
    )
  end

  it "renders new notification form" do
    render

    response.should have_tag("form[action=?][method=post]", notifications_path) do
      with_tag("input#notification_user_id[name=?]", "notification[user_id]")
      with_tag("input#notification_book_id[name=?]", "notification[book_id]")
    end
  end
end
