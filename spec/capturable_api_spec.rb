require "spec_helper"
require File.join(File.dirname(__FILE__), '..', 'lib', 'devise_capturable', 'api')

describe 'CaptureAPI' do

	before(:each) do
		CaptureAPI.endpoint = "https://something.dev.janraincapture.com"
		CaptureAPI.client_id = "thisis"
		CaptureAPI.client_secret = "atest"
    CaptureAPI.redirect_uri = "http://doesthismatter.com?"
	end

  it "should set base_uri" do        
    CaptureAPI.base_uri.should == "https://something.dev.janraincapture.com"
    CaptureAPI.client_id.should == "thisis"
    CaptureAPI.client_secret.should == "atest"
    CaptureAPI.redirect_uri.should == "http://doesthismatter.com?"
  end

  it "should get token from code" do
  	CaptureAPI.should_receive(:post).with("/oauth/token", :query => {
        code: "abcdef",
        redirect_uri: "http://doesthismatter.com?",
        grant_type: 'authorization_code',
        client_id: "thisis",
        client_secret: "atest",
      }).and_return({"yeah" => "Yeah"})
  	CaptureAPI.token("abcdef")
  end

end