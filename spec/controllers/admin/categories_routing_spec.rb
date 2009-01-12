require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::CategoriesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "admin_categories", :action => "index").should == "/admin_categories"
    end
  
    it "should map #new" do
      route_for(:controller => "admin_categories", :action => "new").should == "/admin_categories/new"
    end
  
    it "should map #show" do
      route_for(:controller => "admin_categories", :action => "show", :id => 1).should == "/admin_categories/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "admin_categories", :action => "edit", :id => 1).should == "/admin_categories/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "admin_categories", :action => "update", :id => 1).should == "/admin_categories/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "admin_categories", :action => "destroy", :id => 1).should == "/admin_categories/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/admin_categories").should == {:controller => "admin_categories", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/admin_categories/new").should == {:controller => "admin_categories", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/admin_categories").should == {:controller => "admin_categories", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/admin_categories/1").should == {:controller => "admin_categories", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/admin_categories/1/edit").should == {:controller => "admin_categories", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/admin_categories/1").should == {:controller => "admin_categories", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/admin_categories/1").should == {:controller => "admin_categories", :action => "destroy", :id => "1"}
    end
  end
end
