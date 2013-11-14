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
    @mapping = mock(:mapping)
    @mapping.should_receive(:to).and_return(User)
    @strategy.should_receive(:mapping).and_return(@mapping)
    @strategy.should_receive(:params).at_least(1).and_return(PARAMS)
    @user = User.new
    @user.stub(:set_capturable_params)
    Devise::Capturable::API.stub(:token).and_return(TOKEN)
    Devise::Capturable::API.stub(:entity).and_return(ENTITY)
  end
  
  it "should authenticate and set capturable params if a user exists in database" do
    User.stub(:capturable_auto_create_account?).and_return(true)
    @user.stub(:save).and_return(true)
    User.should_receive(:find_with_capturable_params).with(ENTITY["result"]).and_return(@user)
    @user.should_receive(:set_capturable_params).with(ENTITY["result"]).and_return(true)
    @strategy.should_receive(:"success!").with(@user).and_return(true)
    lambda { @strategy.authenticate! }.should_not raise_error
  end
    
  describe 'when no user exists in database' do
    
    before(:each) do
      User.should_receive(:find_with_capturable_params).and_return(nil)
    end
              
    it "should fail unless capturable_auto_create_account" do
      User.should_receive(:"capturable_auto_create_account?").and_return(false)
      @strategy.should_receive(:"fail!").with(:capturable_invalid).and_return(true)
      lambda { @strategy.authenticate! }.should_not raise_error
    end
    
    it "should create a new user and success if capturable_auto_create_account" do
      User.should_receive(:"capturable_auto_create_account?").and_return(true)
      User.should_receive(:new).and_return(@user)
      @user.should_receive(:"set_capturable_params").with(ENTITY["result"]).and_return(true)
      @user.should_receive(:save).with({ :validate => false }).and_return(true)
      @strategy.should_receive(:"success!").with(@user).and_return(true)
      lambda { @strategy.authenticate! }.should_not raise_error
    end
  end

end