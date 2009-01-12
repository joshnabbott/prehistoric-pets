require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CategoriesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "categories", :action => "index").should == "/categories"
    end
  
    it "should map #new" do
      route_for(:controller => "categories", :action => "new").should == "/categories/new"
    end
  
    it "should map #show" do
      route_for(:controller => "categories", :action => "show", :id => 1).should == "/categories/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "categories", :action => "edit", :id => 1).should == "/categories/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "categories", :action => "update", :id => 1).should == "/categories/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "categories", :action => "destroy", :id => 1).should == "/categories/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/categories").should == {:controller => "categories", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/categories/new").should == {:controller => "categories", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/categories").should == {:controller => "categories", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/categories/1").should == {:controller => "categories", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/categories/1/edit").should == {:controller => "categories", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/categories/1").should == {:controller => "categories", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/categories/1").should == {:controller => "categories", :action => "destroy", :id => "1"}
    end
  end
end
