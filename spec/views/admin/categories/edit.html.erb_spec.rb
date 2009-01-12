require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin_categories/edit.html.erb" do
  include Admin::CategoriesHelper
  
  before(:each) do
    assigns[:category] = @category = stub_model(Admin::Category,
      :new_record? => false,
      :parent => ,
      :name => "value for name",
      :description => "value for description",
      :position => "1"
    )
  end

  it "should render edit form" do
    render "/admin_categories/edit.html.erb"
    
    response.should have_tag("form[action=#{category_path(@category)}][method=post]") do
      with_tag('input#category_parent[name=?]', "category[parent]")
      with_tag('input#category_name[name=?]', "category[name]")
      with_tag('textarea#category_description[name=?]', "category[description]")
      with_tag('input#category_position[name=?]', "category[position]")
    end
  end
end


