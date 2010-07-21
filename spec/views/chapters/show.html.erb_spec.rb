require 'spec_helper'

describe "/chapters/show.html.erb" do
  include ChaptersHelper
  before(:each) do
    assigns[:chapter] = @chapter = stub_model(Chapter,
      :parent_id => 1,
      :parent_type => "value for parent_type",
      :type => "value for type",
      :title => "value for title",
      :position => 1,
      :content => "value for content"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/value\ for\ parent_type/)
    response.should have_text(/value\ for\ type/)
    response.should have_text(/value\ for\ title/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ content/)
  end
end
