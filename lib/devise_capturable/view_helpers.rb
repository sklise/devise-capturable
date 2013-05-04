unless defined?(ActionView)
  require 'action_view'
end

module Devise
  module Capturable
    module Helpers
      
      include ActionView::Helpers::UrlHelper

      def link_to_capturable(link_text, options={})
    		options = { :id => "capture_signin_link", :class => "capture_modal_open" }.merge(options)
        link_to(link_text, "#", options)
      end

    end
  end
end

::ActionView::Base.send :include, Devise::Capturable::Helpers