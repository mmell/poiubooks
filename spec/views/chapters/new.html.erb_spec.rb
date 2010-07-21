require 'spec_helper'

describe "/chapters/new.html.erb" do
  include ChaptersHelper

  before(:each) do
    assigns[:chapter] = stub_model(Chapter,
      :new_record? => true,
      :parent_id => 1,
      :parent_type => "value for parent_type",
      :type => "value for type",
      :title => "value for title",
      :position => 1,
      :content => "value for content"
    )
  end

  it "renders new chapter form" do
    render

    response.should have_tag("form[action=?][method=post]", chapters_path) do
      with_tag("input#chapter_parent_id[name=?]", "chapter[parent_id]")
      with_tag("input#chapter_parent_type[name=?]", "chapter[parent_type]")
      with_tag("input#chapter_type[name=?]", "chapter[type]")
      with_tag("input#chapter_title[name=?]", "chapter[title]")
      with_tag("input#chapter_position[name=?]", "chapter[position]")
      with_tag("textarea#chapter_content[name=?]", "chapter[content]")
    end
  end
end
