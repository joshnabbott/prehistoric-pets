require 'spec/spec_helper'

describe Scrooge::Tracker::Model do
  
  before(:each) do
    @model = Scrooge::Tracker::Model.new( 'Post' )
    @model.stub!(:name).and_return( 'Product' )
    @model.stub!(:table_name).and_return( 'products' )
    @model.stub!(:primary_key).and_return( 'id' )    
    @other_model = Scrooge::Tracker::Model.new( 'OtherPost' )
    @another_model = Scrooge::Tracker::Model.new( 'AnotherPost' )
    @resource = Scrooge::Tracker::Resource.new do |resource|
                  resource.controller = 'products'
                  resource.action = 'show'
                  resource.method = :get
                  resource.format = :html
                  resource.is_public = true
                end    
  end

  it "should be able to determine if any attributes has been tracked" do
    @model.any?().should equal( false )
  end
  
  it "should initialize with an empty set of attributes" do
    @model.attributes.should eql( Set.new )
  end
  
  it "should be able to accept attributes" do
    lambda { @model << :name }.should change( @model.attributes, :size ).from(0).to(1)
  end
  
  it "should be able to dump itself to a serializeable representation" do
    @model << [:name, :description, :price]
    @model.marshal_dump().should eql( { "Product" => [:price, :description, :name] } )
  end
  
  it "should be able to restore itself from a serialized representation" do
    @model << [:name, :description, :price]
    @model.marshal_load( { "Product" => [:price] } )
    @model.attributes.size.should eql( 1 )
  end
  
  it "should be able to render a attribute selection SQL snippet from it's referenced attributes" do
    @model << [:name, :description, :price]
    @model.to_sql().should eql( "products.id, products.price, products.description, products.name" )
  end
  
  it "should be able to compare itself to other model trackers" do
    @model << [:name, :description, :price]
    @model.should eql( @model )
  end
  
  it "should implemented a custom Object#inspect" do
    @model << [:name, :description]
    @model.inspect().should match( /Product/ )
    @model.inspect().should match( /:name/ )
  end
  
  it "should be able to merge itself with another model tracker" do
    @other_model << %w(name description)
    @model.merge( @other_model )
    @model.attributes.to_a.sort.should eql( %w(description name) )
    @another_model.merge( @model )
    @another_model.attributes.to_a.sort.should eql( %w(description name) )
    @another_model.attributes.should_not_receive(:merge)
    @another_model.merge( nil )
  end
  
  it "should be able to setup Rack middleware" do
    @model << %w(name description)
    @model.middleware( @resource ).class.should equal( Class )
    @model.middleware( @resource ).inspect.should match( /Middleware/ )
    @model.middleware( @resource ).inspect.should match( /Product/ )
    @model.middleware( @resource ).inspect.should match( /description/ )    
    @model.middleware( @resource ).new( @model ).should respond_to( :call )
  end
  
end