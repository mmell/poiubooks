ActionController::Routing::Routes.draw do |map|
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => ''
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'

# thanks http://www.railsforum.com/viewtopic.php?id=11962
  map.forgot    '/forgot', :controller => 'users', :action => 'forgot'
  map.reset     '/reset/:code', :controller => 'users', :action => 'reset'
  map.reset_password     '/reset_password', :controller => 'users', :action => 'reset'
  
  map.read_sub_chapter( 'books/:book_id/:chapter_position/:sub_chapter_position', 
    :controller => 'sub_chapters', :action => 'read', 
    :requirements => { :book_id => /\d+/, :chapter_position => /\d+/, :sub_chapter_position => /\d+/ }, 
    :conditions => { :method => :get } 
    )
  map.read_chapter( 'books/:book_id/:chapter_position', 
    :controller => 'chapters', :action => 'read', 
    :requirements => { :book_id => /\d+/, :chapter_position => /\d+/ }, 
    :conditions => { :method => :get } 
    )
  map.read_book( 'books/:book_id', 
    :controller => 'books', :action => 'read', 
    :requirements => { :book_id => /\d+/ }, 
    :conditions => { :method => :get } 
    )

  #  map.activate ‘/activate/:activation_code’, :controller => ‘users’, :action => ‘activate’, :activation_code => nil
  map.resources( :users, { :member => { :suspend=>:put, :unsuspend=>:put, :purge=>:delete } } ) do |user|
    user.resources :books
    user.resources :comments
    user.resources :notifications
  end

  map.resource :session

  map.resources( :books, { :collection => { :advanced_search => :post } } ) do |books|
    books.resources( :chapters, { :member => { :position => :post } })
    books.resources :comments
    books.resources :notifications
  end

  map.resources :chapters do |chapter|
    chapter.resources( :sub_chapters, { :member => { :position => :post } })
    chapter.resources :comments
  end

  map.resources :sub_chapters do |chapter|
    chapter.resources :comments
  end

  map.resources :categories do |category|
    category.resources :books
  end
  
  map.resources :comments
  map.vote_on_comment 'comments/vote/:id/:thumbs', :controller => 'comments', :action => 'vote'
  
  map.resources :notifications
  map.resources :licenses

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "books"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
