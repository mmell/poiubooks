class BooksController < ApplicationController
  
  before_filter :find_user_book, :except => [:index, :show, :new, :create]
  before_filter :require_user, :except => [:index, :show]
  
  # GET /books
  # GET /books.xml
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id], :include => :books)
      @books = @category.books.all
      @page_title = "Listing Books in Category: #{@category.name}"
    elsif params[:user_id]
      @user = User.find(params[:user_id], :include => :books)
      @books = @user.books.all
      @page_title = "Listing Books by Author: #{@user.full_name}"
    else
      @page_title = "Listing All Books"
      @books = Book.all
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @books }
    end
  end

  # GET /books/1
  # GET /books/1.xml
  # GET /books/1.rss
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
      format.rss { render :layout => false } # show.rss.builder
    end
  end

#  def rss
#    @book = Book.find(params[:id])
#    render :layout => false
#    response.headers["Content-Type"] = "application/xml; charset=utf-8"
#  end

  # GET /books/1
  # GET /books/1.xml
  def manage
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    use_tinymce
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    use_tinymce
  end

  # POST /books
  # POST /books.xml
  def create
    @book = Book.new(params[:book])
    @book.user_id = current_user.id

    respond_to do |format|
      if @book.save
        flash[:notice] = 'Book was successfully created.'
        format.html { redirect_to(@book) }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
    respond_to do |format|
      if @book.update_attributes(params[:book])
        flash[:notice] = 'Book was successfully updated.'
        format.html { redirect_to(@book) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(books_url) }
      format.xml  { head :ok }
    end
  end

  private
  def find_user_book
    @book = current_user.books.find(params[:id])
    redirect_to user_books_path and return false unless @book
  end

end
