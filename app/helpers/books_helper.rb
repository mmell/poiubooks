module BooksHelper
  def chapter_position_options(ct, ix)
    (0 ... ct).map { |e| "<option value='#{e}'#{e == ix ? " selected='selected'" : ''}>#{e +1}</option>" }.join('')
  end
  
end
