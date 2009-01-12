require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::Category do
  before(:each) do
    @valid_attributes = {
      :parent => ,
      :name => "value for name",
      :description => "value for description",
      :position => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    Admin::Category.create!(@valid_attributes)
  end
end
