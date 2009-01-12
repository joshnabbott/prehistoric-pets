ActionController::Routing::Routes.draw do |map|
  map.resources :categories

  map.admin 'admin/', :controller => 'users'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users
  map.resource :session

  map.namespace(:admin) do |admin|
    admin.resources :categories
  end
end
