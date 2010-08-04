require 'spec_helper'

describe SubChaptersController do

  include ControllerHelpers
  
  def mock_chapters(stubs={})
    @mock_chapters ||= mock_model(SubChapter, stubs)
  end

  describe "GET index" do
    it "assigns all chapters as @chapters" do
      SubChapter.stub(:find).with(:all).and_return([mock_chapters])
      get :index
      assigns[:chapters].should == [mock_chapters]
    end
  end

  describe "GET show" do
    it "assigns the requested chapter as @chapter" do
      SubChapter.stub(:find).with("37").and_return(mock_chapters)
      get :show, :id => "37"
      assigns[:chapter].should equal(mock_chapters)
    end
  end

  describe "GET new" do
    it "assigns a new chapter as @chapter" do
      SubChapter.stub(:new).and_return(mock_chapters)
      get :new
      assigns[:chapter].should equal(mock_chapters)
    end
  end

  describe "GET edit" do
    it "assigns the requested chapter as @chapter" do
      SubChapter.stub(:find).with("37").and_return(mock_chapters)
      get :edit, :id => "37"
      assigns[:chapter].should equal(mock_chapters)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created chapter as @chapter" do
        SubChapter.stub(:new).with({'these' => 'params'}).and_return(mock_chapters(:save => true))
        post :create, :chapter => {:these => 'params'}
        assigns[:chapter].should equal(mock_chapters)
      end

      it "redirects to the created chapter" do
        SubChapter.stub(:new).and_return(mock_chapters(:save => true))
        post :create, :chapter => {}
        response.should redirect_to(chapter_url(mock_chapters))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved chapter as @chapter" do
        SubChapter.stub(:new).with({'these' => 'params'}).and_return(mock_chapters(:save => false))
        post :create, :chapter => {:these => 'params'}
        assigns[:chapter].should equal(mock_chapters)
      end

      it "re-renders the 'new' template" do
        SubChapter.stub(:new).and_return(mock_chapters(:save => false))
        post :create, :chapter => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested chapter" do
        SubChapter.should_receive(:find).with("37").and_return(mock_chapters)
        mock_chapters.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :chapter => {:these => 'params'}
      end

      it "assigns the requested chapter as @chapter" do
        SubChapter.stub(:find).and_return(mock_chapters(:update_attributes => true))
        put :update, :id => "1"
        assigns[:chapter].should equal(mock_chapters)
      end

      it "redirects to the chapter" do
        SubChapter.stub(:find).and_return(mock_chapters(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(chapter_url(mock_chapters))
      end
    end

    describe "with invalid params" do
      it "updates the requested chapter" do
        SubChapter.should_receive(:find).with("37").and_return(mock_chapters)
        mock_chapters.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :chapter => {:these => 'params'}
      end

      it "assigns the chapter as @chapter" do
        Chapter.stub(:find).and_return(mock_chapters(:update_attributes => false))
        put :update, :id => "1"
        assigns[:chapter].should equal(mock_chapters)
      end

      it "re-renders the 'edit' template" do
        Chapter.stub(:find).and_return(mock_chapters(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested chapter" do
      Chapter.should_receive(:find).with("37").and_return(mock_chapters)
      mock_chapters.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the chapters list" do
      Chapter.stub(:find).and_return(mock_chapters(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(chapters_url)
    end
  end

end
