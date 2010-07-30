require 'spec_helper'

describe "/chapters/index.html.erb" do
  include ChaptersHelper

  before(:each) do
    assigns[:chapters] = [
      stub_model(Chapter,
        :book_id => 1,
        :type => "value for type",
        :title => "value for title",
        :position => 1,
        :content => "value for content"
      ),
      stub_model(Chapter,
        :book_id => 1,
        :type => "value for type",
        :title => "value for title",
        :position => 1,
        :content => "value for content"
      )
    ]
  end

  it "renders a list of chapters" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for type".to_s, 2)
    response.should have_tag("tr>td", "value for title".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for content".to_s, 2)
  end
end
