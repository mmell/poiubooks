class ChaptersController < ApplicationController

  before_filter :require_user, :except => [:show] 
  before_filter :find_user_book, :only => [:new, :create]
  before_filter :find_user_chapter, :except => [:index, :show, :new, :create]
  
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
    @chapter = @book.chapters.build()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chapter }
    end
  end

  # GET /chapters/1/edit
  def edit
    #@chapter = @book.chapters.find(params[:id])
  end

  # POST /chapters
  # POST /chapters.xml
  def create
    @chapter = @book.chapters.new(params[:chapter])
    @chapter.user_id = current_user.id

    respond_to do |format|
      if @chapter.save
        flash[:notice] = 'Chapter was successfully created.'
        format.html { redirect_to(@book, @chapter) }
        format.xml  { render :xml => @chapter, :status => :created, :location => @chapter }
      else
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
        format.html { redirect_to(@chapter) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chapter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.xml
  def destroy
    respond_to do |format|
      format.html { redirect_to(chapters_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def find_user_book
    @book = current_user.books.find(params[:book_id])
    redirect_to root_path and return false unless @book
  end

  def find_user_chapter
    @chapter = current_user.chapters.find(params[:id], :include => :parent)
    redirect_to root_path and return false unless @chapter
  end
  
end
