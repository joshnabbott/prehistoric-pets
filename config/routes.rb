ActionController::Routing::Routes.draw do |map|
  map.resources :shipping_categories

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :announcements, :users, :caresheets, :products
  map.resources :caresheets, :only => :show

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
    admin.resources :asset_categories
    admin.resources :caresheets
    admin.resources :categories, :collection => { :update_positions => :post } do |category|
      category.resources :products do |product|
        product.resources :images, :collection => { :swfupload => :post }  do |image|
          image.resources :crops
        end
      end
    end
    admin.resources :crop_definitions
    admin.resources :images, :collection => { :swfupload => :post }, :has_many => [ :crops ]
    admin.resources :post_o_matic_categories, :has_many => [ :post_o_matic_postings ]
    admin.resources :post_o_matic_postings, :collection => { :update_positions => :post }
    admin.resources :shipping_categories
  end

  # Path for crop
  map.cropped_product_image '/products/:id/:size.:format', :controller => 'products', :action => 'show', :requirements => { :size => /\d+x\d+/ }
  map.cropped_announcement_image '/announcements/:id/:size.:format', :controller => 'announcements', :action => 'show', :requirements => { :size => /\d+x\d+/ }

  # Asset manager
  map.cropped_image '/images/:id/:name.:format', :controller => 'images', :action => 'show', :requirements => { :name => /[0-9a-z]{32}/ }

  # Categories: using globbed routes since I'm not sure how many categories deep this could go
  # and I would like a breadcrumb-like url (/browse/pythons/ball-pythons).
  map.category 'browse/*categories', :controller => 'categories', :action => 'show'
  map.static '*path', :controller => 'static', :action => 'show'
end