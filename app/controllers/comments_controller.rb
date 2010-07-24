class CommentsController < ApplicationController

  before_filter :find_user_comment, :except => [:index, :show, :new, :create, :vote]
  before_filter :require_user, :except => [:index, :show]

  # GET /comments
  # GET /comments.xml
  def index
    redirect_to(books_path) and return false unless params[:user_id]
    @user = User.find(params[:user_id], :include => :comments)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user.comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.xml
  def create
    if params[:chapter_id]
      commentable = Chapter.find(params[:chapter_id])
    elsif params[:book_id]
      commentable = Book.find(params[:book_id])
    end
    
    @comment = commentable.comments.new(params[:comment])
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to_parent }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def vote
    return unless find_votable_comment
    if !@comment.vote.nil?
      @comment.toggle!(:vote)
    else
      @comment.update_attributes(:vote => params[:thumbs] == 'up')
    end
    redirect_to_parent
  end
  
  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end

  private
  def redirect_to_parent
    redirect_to(
      @comment.commentable.is_a?(Book) ? @comment.commentable : [@comment.commentable.book, @comment.commentable]
    )
  end
  
  def find_votable_comment
    @comment = Comment.find(params[:id], :include => :commentable)
    @comment = nil unless @comment.commentable.owner?(current_user)
    redirect_to user_comments_path and return false unless @comment
    true
  end
  
  def find_user_comment
    @comment = current_user.comments.find(params[:id], :include => :commentable)
    redirect_to user_comments_path and return false unless @comment
  end

end
