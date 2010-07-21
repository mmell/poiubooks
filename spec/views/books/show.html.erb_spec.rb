require 'spec_helper'

describe "/books/show.html.erb" do
  include BooksHelper
  before(:each) do
    assigns[:book] = @book = stub_model(Book,
      :user_id => 1,
      :title => "value for title",
      :category_id => 1,
      :reward => "value for reward",
      :license_id => 1,
      :terms => "value for terms"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/value\ for\ title/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ reward/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ terms/)
  end
end
