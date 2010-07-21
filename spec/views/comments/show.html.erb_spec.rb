require 'spec_helper'

describe "/comments/show.html.erb" do
  include CommentsHelper
  before(:each) do
    assigns[:comment] = @comment = stub_model(Comment,
      :user_id => 1,
      :commentable_type => "value for commentable_type",
      :commentable_id => 1,
      :vote => 1,
      :content => "value for content"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/value\ for\ commentable_type/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ content/)
  end
end
