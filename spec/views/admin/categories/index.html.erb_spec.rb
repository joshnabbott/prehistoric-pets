require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin_categories/index.html.erb" do
  include Admin::CategoriesHelper
  
  before(:each) do
    assigns[:admin_categories] = [
      stub_model(Admin::Category,
        :parent => ,
        :name => "value for name",
        :description => "value for description",
        :position => "1"
      ),
      stub_model(Admin::Category,
        :parent => ,
        :name => "value for name",
        :description => "value for description",
        :position => "1"
      )
    ]
  end

  it "should render list of admin_categories" do
    render "/admin_categories/index.html.erb"
    response.should have_tag("tr>td", , 2)
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "value for description", 2)
    response.should have_tag("tr>td", "1", 2)
  end
end

