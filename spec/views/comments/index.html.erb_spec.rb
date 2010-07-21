require 'spec_helper'

describe "/comments/index.html.erb" do
  include CommentsHelper

  before(:each) do
    assigns[:comments] = [
      stub_model(Comment,
        :user_id => 1,
        :commentable_type => "value for commentable_type",
        :commentable_id => 1,
        :vote => 1,
        :content => "value for content"
      ),
      stub_model(Comment,
        :user_id => 1,
        :commentable_type => "value for commentable_type",
        :commentable_id => 1,
        :vote => 1,
        :content => "value for content"
      )
    ]
  end

  it "renders a list of comments" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for commentable_type".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for content".to_s, 2)
  end
end
