require 'spec/spec_helper'

describe Scrooge::Strategy::Track do
  
  before(:each) do
    Scrooge::Base.profile.stub!(:warmup).and_return( 1 )
    @track = Scrooge::Strategy::Track.new
    @controller = Scrooge::Strategy::Controller.new( @track )
    Scrooge::Base.profile.framework.stub!(:install_tracking_middleware).and_return('installed')
    Scrooge::Base.profile.stub!(:start_tracking!).and_return('tracking')
  end
  
  it "should be able to execute a given strategy" do
    with_rails do
      lambda{ @controller.run!().value }.should raise_error( SystemExit )
    end
  end
  
end