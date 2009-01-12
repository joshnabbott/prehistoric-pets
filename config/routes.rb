ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users
  map.resource :session

  # Admin
  map.admin 'admin/', :controller => 'categories'
  map.namespace(:admin) do |admin|
    admin.resources :categories
  end

  # Categories: using globbed routes since I'm not sure how many categories deep this could go
  # and I would like a breadcrumb-like url.
  map.category '*categories/:id', :controller => 'categories', :action => 'show'
end