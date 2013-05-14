require "spec_helper"
require File.join(File.dirname(__FILE__), '..', 'lib', 'devise_capturable', 'api')

describe 'Devise::Capturable::API' do

	before(:each) do
		Devise.stub(:capturable_server).and_return("https://something.dev.janraincapture.com")
    Devise.stub(:capturable_client_id).and_return("thisis")
    Devise.stub(:capturable_client_secret).and_return("atest")
	end

  it "should get token from code" do
  	Devise::Capturable::API.should_receive(:post).with("https://something.dev.janraincapture.com/oauth/token", :query => {
        code: "abcdef",
        redirect_uri: "http://stupidsettings.com",
        grant_type: 'authorization_code',
        client_id: "thisis",
        client_secret: "atest",
      }).and_return({"yeah" => "Yeah"})
  	Devise::Capturable::API.token("abcdef")
  end

  it "should get entity from token" do
    Devise::Capturable::API.should_receive(:post).with("https://something.dev.janraincapture.com/entity", :headers => { 
      'Authorization' => "OAuth abcdef" }).and_return({"yeah" => "Yeah"})
    Devise::Capturable::API.entity("abcdef")
  end

end