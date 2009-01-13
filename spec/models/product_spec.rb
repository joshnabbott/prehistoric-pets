require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Product do
  before(:each) do
    @valid_attributes = {
      :category => mock_model(Category),
      :name => "value for name",
      :scientific_name => "value for scientific_name",
      :sku => "value for sku",
      :description => "value for description",
      :comments => "value for comments",
      :price => "9.99",
      :override => false,
      :is_active => false,
      :has_caresheet => false,
      :is_featured => false
    }
  end

  it "should create a new instance given valid attributes" do
    Product.create!(@valid_attributes)
  end
end
