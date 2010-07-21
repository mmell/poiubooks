require 'spec_helper'

describe CategoriesController do

  include ControllerHelpers
  
  def mock_categories(stubs={})
    @mock_categories ||= mock_model(Category, stubs)
  end

  describe "GET index" do
    it "assigns all categories as @categories" do
      r = [mock_categories, mock_categories]
      Category.stub(:find).with(:all).and_return(r)
      get :index
      assigns[:categories].should == r
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      Category.stub(:find).with("37").and_return(mock_categories)
      get :show, :id => "37"
      assigns[:category].should equal(mock_categories)
    end
  end

  describe "GET new" do
    it "redirects unless user#is_admin?" do
      get :new
      response.should redirect_to(root_url)
    end

    it "assigns a new category as @category" do
      make_admin_user_session
      Category.stub(:new).and_return(mock_categories)
      get :new
      assigns[:category].should equal(mock_categories)
    end
  end

  describe "GET edit" do
    it "assigns the requested category as @category" do
      make_admin_user_session
      Category.stub(:find).with("37").and_return(mock_categories)
      get :edit, :id => "37"
      response.should render_template('edit')
      assigns[:category].should equal(mock_categories)
    end
  end

  describe "POST create" do

    before(:each) do
      make_admin_user_session
    end

    describe "with valid params" do
      it "assigns a newly created category as @category" do
        Category.stub(:new).with({"name" => 'new name'}).and_return(mock_categories(:save => true))
        post :create, :category => {"name" => 'new name'}
        assigns[:category].should equal(mock_categories)
      end

      it "redirects to the created category" do
        Category.stub(:new).and_return(mock_categories(:save => true))
        post :create, :category => {}
        response.should redirect_to(category_url(mock_categories))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        Category.stub(:new).with({"name" => 'new name'}).and_return(mock_categories(:save => false))
        post :create, :category => {"name" => 'new name'}
        assigns[:category].should equal(mock_categories)
      end

      it "re-renders the 'new' template" do
        Category.stub(:new).and_return(mock_categories(:save => false))
        post :create, :category => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    before(:each) do
      make_admin_user_session
    end

    describe "with valid params" do
      it "updates the requested category" do
        Category.should_receive(:find).with("37").and_return(mock_categories)
        mock_categories.should_receive(:update_attributes).with({"name" => 'new name'})
        put :update, :id => "37", :category => {"name" => 'new name'}
      end

      it "assigns the requested category as @category" do
        Category.stub(:find).and_return(mock_categories(:update_attributes => true))
        put :update, :id => "1"
        assigns[:category].should equal(mock_categories)
      end

      it "redirects to the category" do
        Category.stub(:find).and_return(mock_categories(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(category_url(mock_categories))
      end
    end

    describe "with invalid params" do
      it "updates the requested category" do
        Category.should_receive(:find).with("37").and_return(mock_categories)
        mock_categories.should_receive(:update_attributes).with({"name" => 'new name'})
        put :update, :id => "37", :category => {"name" => 'new name'}
      end

      it "assigns the category as @category" do
        Category.stub(:find).and_return(mock_categories(:update_attributes => false))
        put :update, :id => "1"
        assigns[:category].should equal(mock_categories)
      end

      it "re-renders the 'edit' template" do
        Category.stub(:find).and_return(mock_categories(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    before(:each) do
      make_admin_user_session
    end

    it "destroys the requested category" do
      Category.should_receive(:find).with("37").and_return(mock_categories)
      mock_categories.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the categories list" do
      Category.stub(:find).and_return(mock_categories(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(categories_url)
    end
  end

end
