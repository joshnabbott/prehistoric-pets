require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/categories/show.html.erb" do
  include CategoriesHelper
  
  before(:each) do
    assigns[:category] = @category = stub_model(Category,
      :parent => ,
      :name => "value for name",
      :description => "value for description",
      :position => "1"
    )
  end

  it "should render attributes in <p>" do
    render "/categories/show.html.erb"
    response.should have_text(//)
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/1/)
  end
end

