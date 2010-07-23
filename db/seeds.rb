Category.create( :name => 'Book' )
Category.create( :name => 'Script' )
Category.create( :name => 'Research Paper' )
Category.create( :name => 'Speech' )
Category.create( :name => 'Poem' )
Category.create( :name => 'White Paper' )

License.create(
  :name => 'Attribution', 
  :url => 'http://creativecommons.org/licenses/by/3.0', 
  :image_src => 'http://i.creativecommons.org/l/by/3.0/88x31.png'
)
License.create(
  :name => 'Attribution Share Alike', 
  :url => 'http://creativecommons.org/licenses/by-sa/3.0', 
  :image_src => 'http://i.creativecommons.org/l/by-sa/3.0/88x31.png'
)
License.create(
  :name => 'Attribution No Derivatives', 
  :url => 'http://creativecommons.org/licenses/by-nd/3.0', 
  :image_src => 'http://i.creativecommons.org/l/by-nd/3.0/88x31.png'
)
License.create(
  :name => 'Attribution Non-Commercial', 
  :url => 'http://creativecommons.org/licenses/by-nc/3.0', 
  :image_src => 'http://i.creativecommons.org/l/by-nc/3.0/88x31.png'
)
License.create(
  :name => 'Attribution Non-Commercial Share Alike', 
  :url => 'http://creativecommons.org/licenses/by-nc-sa/3.0', 
  :image_src => 'http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png'
)
License.create(
  :name => 'Attribution Non-Commercial No Derivatives', 
  :url => 'http://creativecommons.org/licenses/by-nc-nd/3.0', 
  :image_src => 'http://i.creativecommons.org/l/by-nc-nd/3.0/88x31.png'
)
