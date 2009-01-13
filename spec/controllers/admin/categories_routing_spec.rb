require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::CategoriesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "admin/categories", :action => "index").should == "/admin/categories"
    end
  
    it "should map #new" do
      route_for(:controller => "admin/categories", :action => "new").should == "/admin/categories/new"
    end
  
    it "should map #show" do
      route_for(:controller => "admin/categories", :action => "show", :id => 1).should == "/admin/categories/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "admin/categories", :action => "edit", :id => 1).should == "/admin/categories/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "admin/categories", :action => "update", :id => 1).should == "/admin/categories/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "admin/categories", :action => "destroy", :id => 1).should == "/admin/categories/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/admin/categories").should == {:controller => "admin/categories", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/admin/categories/new").should == {:controller => "admin/categories", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/admin/categories").should == {:controller => "admin/categories", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/admin/categories/1").should == {:controller => "admin/categories", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/admin/categories/1/edit").should == {:controller => "admin/categories", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/admin/categories/1").should == {:controller => "admin/categories", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/admin/categories/1").should == {:controller => "admin/categories", :action => "destroy", :id => "1"}
    end
  end
end
