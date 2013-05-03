unless defined?(Devise)
  require 'devise'
end

require 'devise_capturable/api'
require 'devise_capturable/model'
require 'devise_capturable/strategy'
Warden::Strategies.add(:capturable, Devise::Capturable::Strategies::Capturable)
require 'devise_capturable/view_helpers'

module Devise
  mattr_accessor :capturable_auto_create_account
  @@capturable_auto_create_account = true
end

I18n.load_path.unshift File.join(File.dirname(__FILE__), *%w[devise_capturable locales en.yml])
Devise.add_module(:capturable, :strategy => true, :controller => :sessions, :model => 'devise_capturable/model')
