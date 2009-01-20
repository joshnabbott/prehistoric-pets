ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :announcements, :users, :products
  map.product_image '/products/:id/:size.:format', :controller => 'products', :action => 'show', :size => nil

  map.resource :session
  map.root :controller => 'home'
  map.announcement_pages '/page/:page', :controller => 'home'

  # Admin
  map.admin 'admin/', :controller => 'admin/products'
  map.namespace(:admin) do |admin|
    admin.resources :announcements
    admin.resources :categories
    admin.resources :caresheets
    admin.resources :products
  end

  # Categories: using globbed routes since I'm not sure how many categories deep this could go
  # and I would like a breadcrumb-like url (/snakes/pythons/ball-pythons).
  map.category 'browse/*categories', :controller => 'categories', :action => 'show'
  map.static '*path', :controller => 'static', :action => 'show'
end