ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :announcements, :users, :caresheets, :products

  map.search '/search/:keywords', :controller => 'search', :keywords => nil

  map.resource :session
  map.root :controller => 'home'

  # Cart
  map.cart_checkout '/cart/checkout', :controller => "cart/cart", :action => "checkout", :method => :post

  map.namespace(:cart) do |cart|
    cart.resources :items
    cart.resources :orders
  end

  # Admin
  map.admin 'admin/', :controller => 'admin/categories'
  map.namespace(:admin) do |admin|
    admin.resources :announcements
    admin.resources :categories, :collection => { :update_positions => :post }, :has_many => [ :products ]
    admin.resources :caresheets
    # admin.resources :products
    admin.resources :post_o_matic_categories, :has_many => [ :post_o_matic_postings ]
    admin.resources :post_o_matic_postings, :collection => { :update_positions => :post }
  end

  # Path for crop
  map.cropped_product_image '/products/:id/:size.:format', :controller => 'products', :action => 'show', :requirements => { :size => /\d+x\d+/ }
  map.cropped_announcement_image '/announcements/:id/:size.:format', :controller => 'announcements', :action => 'show', :requirements => { :size => /\d+x\d+/ }

  # Categories: using globbed routes since I'm not sure how many categories deep this could go
  # and I would like a breadcrumb-like url (/browse/pythons/ball-pythons).
  map.category 'browse/*categories', :controller => 'categories', :action => 'show'
  map.static '*path', :controller => 'static', :action => 'show'
end