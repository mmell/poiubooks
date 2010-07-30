require 'spec_helper'

describe BookMailer do
  include ModelHelpers

  before(:each) do
    reset_db
  end
 
  it "should send book comment notification" do
    commentable = Factory.create(:book)
    BookMailer.should_receive(:deliver_book_comment_notification).with(
      commentable, 
      anything()
    )
    Factory.create(:comment, :commentable => commentable, :user => commentable.user)
  end

  it "should send chapter comment notification" do
    commentable = Factory.create(:chapter)
    BookMailer.should_receive(:deliver_chapter_comment_notification).with(
      commentable.book, 
      anything()
    )
    Factory.create(:comment, :commentable => commentable, :user => commentable.user)
  end

  describe "send notifications" do

    before(:each) do
      @book = Factory.create(:book)
      @user = Factory.create(:user)
      @notification = Factory.create(:notification, :book => @book, :user => @user)
    end

    it "should send chapter notification" do
      chapter = Factory.create(:chapter, :book => @book)
      BookMailer.should_receive(:deliver_chapter_notification).with(
        @notification.user,  
        chapter
      )
      chapter.update_attributes(:content => chapter.content << ' new')
    end

    it "should send book notification" do
      BookMailer.should_receive(:deliver_book_notification).with(
        @notification.user, 
        @book
      )
      @book.update_attributes(:reward => @book.reward << ' new')
    end
    
  end

end
