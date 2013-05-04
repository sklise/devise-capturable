require "spec_helper"
require File.join(File.dirname(__FILE__), '..', 'lib', 'devise_capturable', 'api')

describe 'CaptureAPI' do

	before(:each) do
		Devise.stub(:capturable_endpoint).and_return("https://something.dev.janraincapture.com")
    Devise.stub(:capturable_client_id).and_return("thisis")
    Devise.stub(:capturable_client_secret).and_return("atest")
    Devise.stub(:capturable_redirect_uri).and_return("http://doesthismatter.com?")
	end

  it "should get token from code" do
  	CaptureAPI.should_receive(:post).with("https://something.dev.janraincapture.com/oauth/token", :query => {
        code: "abcdef",
        redirect_uri: "http://doesthismatter.com?",
        grant_type: 'authorization_code',
        client_id: "thisis",
        client_secret: "atest",
      }).and_return({"yeah" => "Yeah"})
  	CaptureAPI.token("abcdef")
  end

  it "should get entity from token" do
    CaptureAPI.should_receive(:post).with("https://something.dev.janraincapture.com/entity", :headers => { 
      'Authorization' => "OAuth abcdef" }).and_return({"yeah" => "Yeah"})
    CaptureAPI.entity("abcdef")
  end

end