require 'spec_helper'

describe NotificationsController do

  def mock_notifications(stubs={})
    @mock_notifications ||= mock_model(Notification, stubs)
  end

  describe "GET index" do
    it "assigns all notifications as @notifications" do
      Notification.stub(:find).with(:all).and_return([mock_notifications])
      get :index
      assigns[:notifications].should == [mock_notifications]
    end
  end

  describe "GET show" do
    it "assigns the requested notification as @notification" do
      Notification.stub(:find).with("37").and_return(mock_notifications)
      get :show, :id => "37"
      assigns[:notification].should equal(mock_notifications)
    end
  end

  describe "GET new" do
    it "assigns a new notification as @notification" do
      Notification.stub(:new).and_return(mock_notifications)
      get :new
      assigns[:notification].should equal(mock_notifications)
    end
  end

  describe "GET edit" do
    it "assigns the requested notification as @notification" do
      Notification.stub(:find).with("37").and_return(mock_notifications)
      get :edit, :id => "37"
      assigns[:notification].should equal(mock_notifications)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created notification as @notification" do
        Notification.stub(:new).with({'these' => 'params'}).and_return(mock_notifications(:save => true))
        post :create, :notification => {:these => 'params'}
        assigns[:notification].should equal(mock_notifications)
      end

      it "redirects to the created notification" do
        Notification.stub(:new).and_return(mock_notifications(:save => true))
        post :create, :notification => {}
        response.should redirect_to(notification_url(mock_notifications))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved notification as @notification" do
        Notification.stub(:new).with({'these' => 'params'}).and_return(mock_notifications(:save => false))
        post :create, :notification => {:these => 'params'}
        assigns[:notification].should equal(mock_notifications)
      end

      it "re-renders the 'new' template" do
        Notification.stub(:new).and_return(mock_notifications(:save => false))
        post :create, :notification => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested notification" do
        Notification.should_receive(:find).with("37").and_return(mock_notifications)
        mock_notifications.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :notification => {:these => 'params'}
      end

      it "assigns the requested notification as @notification" do
        Notification.stub(:find).and_return(mock_notifications(:update_attributes => true))
        put :update, :id => "1"
        assigns[:notification].should equal(mock_notifications)
      end

      it "redirects to the notification" do
        Notification.stub(:find).and_return(mock_notifications(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(notification_url(mock_notifications))
      end
    end

    describe "with invalid params" do
      it "updates the requested notification" do
        Notification.should_receive(:find).with("37").and_return(mock_notifications)
        mock_notifications.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :notification => {:these => 'params'}
      end

      it "assigns the notification as @notification" do
        Notification.stub(:find).and_return(mock_notifications(:update_attributes => false))
        put :update, :id => "1"
        assigns[:notification].should equal(mock_notifications)
      end

      it "re-renders the 'edit' template" do
        Notification.stub(:find).and_return(mock_notifications(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested notification" do
      Notification.should_receive(:find).with("37").and_return(mock_notifications)
      mock_notifications.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the notifications list" do
      Notification.stub(:find).and_return(mock_notifications(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(notifications_url)
    end
  end

end
