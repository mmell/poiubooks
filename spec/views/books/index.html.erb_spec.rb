require 'spec_helper'

describe "/books/index.html.erb" do
  include BooksHelper

  before(:each) do
    assigns[:books] = [
      stub_model(Book,
        :user_id => 1,
        :title => "value for title",
        :category_id => 1,
        :reward => "value for reward",
        :license_id => 1,
        :terms => "value for terms"
      ),
      stub_model(Book,
        :user_id => 1,
        :title => "value for title",
        :category_id => 1,
        :reward => "value for reward",
        :license_id => 1,
        :terms => "value for terms"
      )
    ]
  end

  it "renders a list of books" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for title".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for reward".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for terms".to_s, 2)
  end
end
