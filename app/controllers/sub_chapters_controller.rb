class SubChaptersController < ApplicationController

  before_filter :require_user #, :except => [:show] 
  before_filter :find_editable_parent, :only => [:new, :create]
  before_filter :find_editable_sub_chapter, :except => [:index, :show, :new, :create]
  before_filter :clean_submission, :only => [:update, :create]
  
  # GET /chapters/1
  # GET /chapters/1.xml
  def show
    use_tinymce(:simple)
    @sub_chapter = SubChapter.find(params[:id], :include => :parent)
    @chapter = @sub_chapter.chapter
    @book = @chapter.book
    redirect_to book_path(params[:chapter_id]) and return false unless @sub_chapter

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chapter }
    end
  end

  # GET /sub_chapters/new
  # GET /sub_chapters/new.xml
  def new
    use_tinymce
    @sub_chapter = @chapter.sub_chapters.build()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sub_chapter }
    end
  end

  # GET /chapters/1/edit
  def edit
    use_tinymce
  end

  # POST /chapters
  # POST /chapters.xml
  def create
    @sub_chapter = @chapter.sub_chapters.new(params[:sub_chapter]) 
#    raise StandardError, @sub_chapter.inspect

    respond_to do |format|
      if @sub_chapter.save
        flash[:notice] = 'Chapter was successfully created.'
        format.html { redirect_to(@chapter, @sub_chapter) }
        format.xml  { render :xml => @sub_chapter, :status => :created, :location => @sub_chapter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sub_chapter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sub_chapters/1
  # PUT /sub_chapters/1.xml
  def update
    respond_to do |format|
      if @sub_chapter.update_attributes(params[:sub_chapter])
        flash[:notice] = 'Chapter was successfully updated.'
        format.html { redirect_to(@chapter, @sub_chapter) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sub_chapter.errors, :status => :unprocessable_entity }
      end
    end
  end

  def position
    @sub_chapter.parent.shift_chapter_position(@sub_chapter, params[:move_to]) 
    notice_message("Successfully shifted the chapter.")
    redirect_to(edit_chapter_sub_chapter_path(@sub_chapter.chapter, @sub_chapter))
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.xml
  def destroy
    @sub_chapter.destroy
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
    @chapter = current_user.chapters.find(params[:chapter_id], :include => :parent)
    redirect_to root_path and return false unless @chapter
    @book = @chapter.book
  end

  def find_editable_sub_chapter
    @sub_chapter = current_user.sub_chapters.find(params[:id], :include => :parent)
    redirect_to root_path and return false unless @sub_chapter
    @chapter = @sub_chapter.chapter
    @book = @sub_chapter.book
  end

  def clean_submission
    params[:sub_chapter][:title].strip!
  end

end
