module Devise
  
  module Models

    module Capturable

      def self.included(base)
        base.class_eval do
          extend ClassMethods
        end
      end

      # This is called from strategy and is used to fill a user model before creating it
      # It defaults to just setting the email, but you can override this in your user model
      def before_capturable_create(capture_data, params)
        self.email = capture_data["email"]
      end

      # This is called from strategy and *can* be used to update an existing user model if 
      # the data changes on the janrain side. It defaults to doing nothing.
      def before_capturable_sign_in(capture_data, params)
      end

      module ClassMethods

        # This is called from strategy and is used to find a user when returning from janrain
        # It defaults to find_by_uuid, but you can override this in your user model
        def find_with_capturable_params(capture_data)
          self.find_by_email(capture_data["email"])
        end

        protected

        def valid_for_capturable(resource, attributes)
          true
        end

      end

    end
  end
end
