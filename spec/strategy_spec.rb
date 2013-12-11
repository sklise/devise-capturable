require "spec_helper"
require "active_support/all"
require File.join(File.dirname(__FILE__), '..', 'lib', 'devise_capturable', 'strategy')

class User
end

PARAMS = { :code => "abcdefghijklmn" }
TOKEN = {"access_token" => "abcdefg", "stat" => "ok"}
ENTITY = {"result" => { "uuid" => "1234", "email" => "some@email.com" }}

describe 'Devise::Capturable' do
  
  before(:each) do
    @strategy = Devise::Capturable::Strategies::Capturable.new
    @mapping = double(:mapping)
    @user = User.new
    expect(@mapping).to receive(:to).and_return(User)
    expect(@strategy).to receive(:mapping).and_return(@mapping)
    expect(@strategy).to receive(:params).at_least(:once).and_return(PARAMS)
    allow(Devise::Capturable::API).to receive(:token).and_return(TOKEN)
    allow(Devise::Capturable::API).to receive(:entity).and_return(ENTITY)
  end

  describe "for an existing user" do
  
    it "should authenticate" do
      expect(User).to receive(:find_with_capturable_params).with(ENTITY["result"]).and_return(@user)
      expect(@user).to receive(:before_capturable_sign_in).with(ENTITY["result"], PARAMS)
      expect(@user).to_not receive(:save!)
      expect(@strategy).to receive(:success!).with(@user)
      expect { @strategy.authenticate! }.to_not raise_error
    end

  end
    
  describe 'for a new user' do
    
    before(:each) do
      expect(User).to receive(:find_with_capturable_params).and_return(nil)
      expect(User).to receive(:new).and_return(@user)
      expect(@user).to receive(:before_capturable_create).with(ENTITY["result"], PARAMS)
    end
              
    it "should fail if unsuccessful" do
      expect(@user).to receive(:save!).and_raise(Exception)
      expect(@strategy).to_not receive(:success!)
      expect(@strategy).to receive(:fail!).with(:capturable_invalid)
      expect { @strategy.authenticate! }.to_not raise_error
    end
    
    it "should succeed if successful" do
      expect(@user).to receive(:save!).and_return(true)
      expect(@strategy).to receive(:success!).with(@user)
      expect(@strategy).to_not receive(:fail!)
      expect { @strategy.authenticate! }.to_not raise_error
    end
  end

end