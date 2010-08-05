class ChaptersController < ApplicationController

  before_filter :require_user, :except => [:show] 
  before_filter :find_editable_parent, :only => [:new, :create]
  before_filter :find_editable_chapter, :except => [:index, :show, :new, :create]
  before_filter :clean_submission, :only => [:update, :create]
  
  # GET /chapters
  # GET /chapters.xml
  def index
    @books = current_user.books.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @books.map { |e| e.chapters }.flatten }
    end
  end

  # GET /chapters/1
  # GET /chapters/1.xml
  def show
    use_tinymce(:simple)
    @chapter = Chapter.find(params[:id], :include => :parent)
    @book = @chapter.book
    redirect_to book_path(params[:book_id]) and return false unless @chapter

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chapter }
    end
  end

  # GET /chapters/new
  # GET /chapters/new.xml
  def new
    use_tinymce
    @chapter = @book.chapters.build()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chapter }
    end
  end

  # GET /chapters/1/edit
  def edit
    use_tinymce
  end

  # POST /chapters
  # POST /chapters.xml
  def create
    @chapter = @book.chapters.new(params[:chapter])

    respond_to do |format|
      if @chapter.save
        flash[:notice] = 'Chapter was successfully created.'
        format.html { redirect_to([@book, @chapter]) }
        format.xml  { render :xml => @chapter, :status => :created, :location => @chapter }
      else
        use_tinymce
        format.html { render :action => "new" }
        format.xml  { render :xml => @chapter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chapters/1
  # PUT /chapters/1.xml
  def update
    respond_to do |format|
      if @chapter.update_attributes(params[:chapter])
        flash[:notice] = 'Chapter was successfully updated.'
        format.html { redirect_to([@book, @chapter]) }
        format.xml  { head :ok }
      else
        use_tinymce
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chapter.errors, :status => :unprocessable_entity }
      end
    end
  end

  def position
    @chapter.parent.shift_chapter_position(@chapter, params[:move_to]) 
    notice_message("Successfully shifted the chapter.")
    redirect_to(edit_book_path(@chapter.book))
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.xml
  def destroy
    @chapter.destroy
    respond_to do |format|
      format.html { redirect_to(chapters_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def config_layout
    if 'show' == params[:action]
      @content_row = 'layouts/content_rows/read_book'
    else 
      super
    end
  end
  
  def find_editable_parent
    @book = current_user.books.find(params[:book_id])
    redirect_to root_path and return false unless @book
  end

  def find_editable_chapter
    @chapter = current_user.chapters.find(params[:id], :include => :parent)
    redirect_to root_path and return false unless @chapter
    @book = @chapter.book
  end

  def clean_submission
    params[:chapter][:title].strip!
  end

end
