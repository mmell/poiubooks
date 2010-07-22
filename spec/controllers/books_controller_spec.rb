require 'spec_helper'

describe BooksController do

  include ControllerHelpers

  def mock_books(stubs={})
    @mock_books ||= mock_model(Book, stubs)
  end

  describe "GET index" do
    it "assigns all books as @books" do
      Book.stub(:find).with(:all).and_return([mock_books])
      get :index
      assigns[:books].should == [mock_books]
    end
  end

  describe "GET show" do
    it "assigns the requested book as @book" do
      Book.stub(:find).with("37").and_return(mock_books)
      get :show, :id => "37"
      assigns[:book].should equal(mock_books)
    end
  end

  describe "GET new" do
    before(:each) do
      make_user_session
    end

    it "assigns a new book as @book" do
      Book.stub(:new).and_return(mock_books)
      get :new
      assigns[:book].should equal(mock_books)
    end
  end

  describe "GET edit" do
    before(:each) do
      make_user_session
    end

    it "assigns the requested book as @book" do
      Book.stub(:find).with("37").and_return(mock_books)
      get :edit, :id => "37"
      assigns[:book].should equal(mock_books)
    end
  end

  describe "POST create" do

    before(:each) do
      make_user_session
    end

    describe "with valid params" do
      it "assigns a newly created book as @book" do
        Book.stub(:new).with({'these' => 'params'}).and_return(mock_books(:save => true))
        post :create, :book => {:these => 'params'}
        assigns[:book].should equal(mock_books)
      end

      it "redirects to the created book" do
        Book.stub(:new).and_return(mock_books(:save => true))
        post :create, :book => {}
        response.should redirect_to(book_url(mock_books))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved book as @book" do
        Book.stub(:new).with({'these' => 'params'}).and_return(mock_books(:save => false))
        post :create, :book => {:these => 'params'}
        assigns[:book].should equal(mock_books)
      end

      it "re-renders the 'new' template" do
        Book.stub(:new).and_return(mock_books(:save => false))
        post :create, :book => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    before(:each) do
      make_user_session
    end

    describe "with valid params" do
      it "updates the requested book" do
        Book.should_receive(:find).with("37").and_return(mock_books)
        mock_books.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :book => {:these => 'params'}
      end

      it "assigns the requested book as @book" do
        Book.stub(:find).and_return(mock_books(:update_attributes => true))
        put :update, :id => "1"
        assigns[:book].should equal(mock_books)
      end

      it "redirects to the book" do
        Book.stub(:find).and_return(mock_books(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(book_url(mock_books))
      end
    end

    describe "with invalid params" do
      it "updates the requested book" do
        Book.should_receive(:find).with("37").and_return(mock_books)
        mock_books.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :book => {:these => 'params'}
      end

      it "assigns the book as @book" do
        Book.stub(:find).and_return(mock_books(:update_attributes => false))
        put :update, :id => "1"
        assigns[:book].should equal(mock_books)
      end

      it "re-renders the 'edit' template" do
        Book.stub(:find).and_return(mock_books(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    before(:each) do
      @user = make_user_session
    end

    it "destroys the requested book" do
      Book.should_receive(:find).with("37").and_return(mock_books(:user_id => @user.id))
      mock_books.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the books list" do
      Book.stub(:find).and_return(mock_books(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(books_url)
    end
  end

end
