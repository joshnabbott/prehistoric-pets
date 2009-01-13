require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::Caresheet do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :scientific_name => "value for scientific_name",
      :permalink => "value for permalink",
      :body => "value for body"
    }
  end

  it "should create a new instance given valid attributes" do
    Admin::Caresheet.create!(@valid_attributes)
  end
end
