require 'spec_helper'

describe "/notifications/edit.html.erb" do
  include NotificationsHelper

  before(:each) do
    assigns[:notification] = @notification = stub_model(Notification,
      :new_record? => false,
      :user_id => 1,
      :book_id => 1
    )
  end

  it "renders the edit notification form" do
    render

    response.should have_tag("form[action=#{notifications_path(@notification)}][method=post]") do
      with_tag('input#notification_user_id[name=?]', "notification[user_id]")
      with_tag('input#notification_book_id[name=?]', "notification[book_id]")
    end
  end
end
