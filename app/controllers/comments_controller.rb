class CommentsController < ApplicationController

  before_filter :require_user, :except => [:index, :show]
  before_filter :find_editable_comment, :except => [:index, :show, :new, :create, :vote]

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
    use_tinymce(:simple)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    use_tinymce(:simple)
  end

  # POST /comments
  # POST /comments.xml
  def create
    if params[:sub_chapter_id]
      commentable = SubChapter.find(params[:sub_chapter_id])
    elsif params[:chapter_id]
      commentable = Chapter.find(params[:chapter_id])
    elsif params[:book_id]
      commentable = Book.find(params[:book_id])
    end
    
    @comment = commentable.comments.build(params[:comment])
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to_commentable(@comment) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        logger.debug(@comment.errors.full_messages.inspect)
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    use_tinymce(:simple) # in case of errors
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to_commentable(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def vote
    Vote.find_or_create_by_user_id_and_comment_id(current_user.id, params[:id]).update_attributes(
      :vote => (params[:thumbs] == 'up')
    )
    redirect_to(:back)
  end
  
  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to_commentable(@comment) }
      format.xml  { head :ok }
    end
  end

  def url_for_comment(comment)
    case comment.commentable_type
    when 'Book'
      url_for(:controller => :books, :action => :show, :id => comment.commentable_id, :anchor => comment.anchor )
    when 'Chapter'
      url_for(:controller => :chapters, :action => :show, :book_id => comment.commentable.parent_id, :id => comment.commentable_id, :anchor => comment.anchor )
    when 'SubChapter'
      chapter_sub_chapter_path(:controller => :sub_chapters, :action => :show, :chapter_id => comment.commentable.parent_id, :id => comment.commentable_id, :anchor => comment.anchor )
    end
  end
   
  private
  def redirect_to_commentable(comment)
    redirect_to(url_for_comment(comment))
  end
  
  def find_editable_comment
    @comment = current_user.comments.find(params[:id], :include => :commentable)
    redirect_to user_comments_path and return false unless @comment
  end

end
