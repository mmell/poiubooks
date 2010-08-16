module ReadController

  def read
    use_tinymce(:simple)
    render( :action => 'show')
  end
  
  def config_layout
    if ['show', 'read'].include?(params[:action])
      @content_row = 'layouts/content_rows/read_book'
    else 
      super
    end
  end
  private :config_layout
end