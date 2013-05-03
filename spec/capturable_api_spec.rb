require "spec_helper"
require File.join(File.dirname(__FILE__), '..', 'lib', 'devise_capturable', 'api')

describe 'Capturable::API' do

	before(:each) do
		Capturable::API.endpoint = "https://something.dev.janraincapture.com"
		Capturable::API.client_id = "thisis"
		Capturable::API.client_secret = "atest"
    Capturable::API.redirect_uri = "http://doesthismatter.com?"
	end

  it "should set base_uri" do        
    Capturable::API.base_uri.should == "https://something.dev.janraincapture.com"
    Capturable::API.client_id.should == "thisis"
    Capturable::API.client_secret.should == "atest"
    Capturable::API.redirect_uri.should == "http://doesthismatter.com?"
  end

  it "should get token from code" do
  	Capturable::API.should_receive(:post).with("/oauth/token", :query => {
        code: "abcdef",
        redirect_uri: "http://doesthismatter.com?",
        grant_type: 'authorization_code',
        client_id: "thisis",
        client_secret: "atest",
      }).and_return({"yeah" => "Yeah"})
  	Capturable::API.token("abcdef")
  end

end