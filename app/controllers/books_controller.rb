class BooksController < ApplicationController

  include ReadController
  
  before_filter :find_readable, :only => [:read] 
  before_filter :require_user, :except => [:read, :index, :show, :search, :advanced_search]
  before_filter :find_editable_book, :except => [:index, :show, :new, :create, :search, :advanced_search, :read]
  before_filter :clean_submission, :only => [:update, :create]
  
  def search
    @books = []
    params[:advanced] = {}
    if params[:search]
      @books << Category.find(:all, 
        :conditions => ["name like ?", "%#{params[:search]}%" ], :include => :books 
      ).map { |e| e.books } 
      @books << Book.find(:all, 
        :conditions => ["title like ?", "%#{params[:search]}%" ] 
      )
      @books << User.find(:all, 
        :conditions => ["name like ?", "%#{params[:search]}%" ], :include => :books 
      ).map { |e| e.books }
      @books << Chapter.find(:all, 
        :conditions => ["content like ?", "%#{params[:search]}%" ], :include => :book 
      ).map { |e| e.book }
      @books = @books.flatten.uniq
        end
  end
  
  def advanced_search
    search_results = []
    params[:advanced] ||= {}
    if params[:advanced]
      unless params[:advanced][:category].blank?
        search_results << Category.find(:all, 
          :conditions => ["name like ?", "%#{params[:advanced][:category]}%" ], :include => :books 
        ).map { |e| e.books }.flatten
      end

      unless params[:advanced][:book].blank?
        search_results << Book.find(:all, :conditions => ["title like ?", "%#{params[:advanced][:book]}%" ] )
      end

      unless params[:advanced][:user].blank?
        search_results << User.find(:all, 
          :conditions => ["name like ?", "%#{params[:advanced][:user]}%" ], :include => :books 
        ).map { |e| e.books }.flatten
      end

      unless params[:advanced][:chapter].blank?
        search_results << Chapter.find(:all, 
          :conditions => ["content like ?", "%#{params[:advanced][:chapter]}%" ], :include => :book 
        ).map { |e| e.book }
      end
      if search_results.empty?
        @books = []
      else
        @books = search_results.pop
      end
      search_results.each { |e| @books = @books & e }
    end
    render(:action => :search)
  end
  
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
      @page_title = "Listing Books by Author: #{@user.name}"
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
    use_tinymce(:simple)
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
      format.rss { render :layout => false } # show.rss.builder
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
  
  def clean_submission
    params[:book][:title].strip!
  end

  def find_editable_book
    @book = current_user.books.find(params[:id])
    redirect_to user_books_path and return false unless @book
  end
  
  def find_readable
    @book = Book.find(params[:id])
    redirect_to root_path and return false unless @book
  end

end
