class NotificationsController < ApplicationController

  before_filter :require_user
  before_filter :find_current_user_notification, :except => [:index, :new, :create, :toggle]

  # GET /notifications
  # GET /notifications.xml
  def index
    if params[:book_id]
      book = Book.find(params[:book_id])
      @partial = 'book_notification'
      @notifications = book.notifications
      @page_title = "Listing Notifications for Book: #{book.title}"
    else 
      if params[:user_id]
        user = User.find(params[:user_id])
        @partial = user == current_user ? 'current_user_notification' : 'user_notification'
        @notifications = user.notifications
        @page_title = "Listing Notifications for User: #{user.full_name}"
      else
        @notifications = current_user.notifications 
        @partial = 'current_user_notification'
        @page_title = "Listing Notifications for #{current_user.full_name}"
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notifications }
    end
  end

  # GET /notifications/1
  # GET /notifications/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @notification }
    end
  end

  # GET /notifications/new
  # GET /notifications/new.xml
  def new
    @notification = Notification.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @notification }
    end
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications
  # POST /notifications.xml
  def create
    @notification = current_user.notifications.new(params[:notification])

    respond_to do |format|
      if @notification.save
        flash[:notice] = 'You will be notified via email when this book or its chapters have been updated.'
        format.html { redirect_to(@notification.book) }
        format.xml  { render :xml => @notification, :status => :created, :location => @notification }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @notification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # POST /notifications
  # POST /notifications.xml
  def toggle
    @notification = current_user.notifications.find_by_book_id(params[:notification][:book_id])
    
    if @notification
      destroy
    else 
      create
    end
  end

  # PUT /notifications/1
  # PUT /notifications/1.xml
  def update
    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        flash[:notice] = 'Notification was successfully updated.'
        format.html { redirect_to(@notification.book) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @notification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.xml
  def destroy
    @notification.destroy
    notice_message("Successfully removed the notification.")
    respond_to do |format|
      format.html { redirect_to( @notification.book ) }
      format.xml  { head :ok }
    end
  end

private 
  def find_current_user_notification
    @notification = current_user.notifications.find(params[:id])
    redirect_to root_path and return false unless @notification
  end

end
