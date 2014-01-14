unless defined?(Devise)
  require 'devise'
end

require 'devise_capturable/model'
require 'devise_capturable/strategy'
Warden::Strategies.add(:capturable, Devise::Capturable::Strategies::Capturable)
require 'devise_capturable/view_helpers'

module Devise
	mattr_accessor :capturable_server
	mattr_accessor :capturable_client_id
	mattr_accessor :capturable_client_secret
	mattr_accessor :capturable_redirect_uri
end

I18n.load_path.unshift File.join(File.dirname(__FILE__), *%w[devise_capturable locales en.yml])
Devise.add_module(:capturable, :strategy => true, :controller => :sessions, :model => 'devise_capturable/model')

module Devise
	module Capturable
  	module Rails
  	  class Engine < ::Rails::Engine
  	  end
  	end
	end
end
