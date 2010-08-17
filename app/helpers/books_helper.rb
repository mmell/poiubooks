module BooksHelper
  def chapter_position_options(ct, ix)
    (1 .. ct).map { |e| "<option value='#{e}'#{e == ix ? " selected='selected'" : ''}>#{e}</option>" }.join('')
  end
  
end
