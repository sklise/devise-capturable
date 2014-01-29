require "spec_helper"
require File.join(File.dirname(__FILE__), '..', 'lib', 'devise_capturable', 'view_helpers')

describe 'View Helpers' do

  it "should generate correct link" do
    class Testing
      include Devise::Capturable::Helpers
    end
    test = Testing.new
    link = test.link_to_capturable("Login")
    link.should == '<a href="#" class="capture_modal_open" id="capture_signin_link">Login</a>'
  end

end