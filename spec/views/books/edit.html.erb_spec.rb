require 'spec_helper'

describe "/books/edit.html.erb" do
  include BooksHelper

  before(:each) do
    assigns[:book] = @book = stub_model(Book,
      :new_record? => false,
      :user_id => 1,
      :title => "value for title",
      :category_id => 1,
      :reward => "value for reward",
      :license_id => 1,
      :terms => "value for terms"
    )
  end

  it "renders the edit books form" do
    render

    response.should have_tag("form[action=#{books_path(@book)}][method=post]") do
      with_tag('input#book_user_id[name=?]', "book[user_id]")
      with_tag('input#book_title[name=?]', "book[title]")
      with_tag('input#book_category_id[name=?]', "book[category_id]")
      with_tag('input#book_reward[name=?]', "book[reward]")
      with_tag('input#book_license_id[name=?]', "book[license_id]")
      with_tag('textarea#book_terms[name=?]', "book[terms]")
    end
  end
end
