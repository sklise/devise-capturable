module Devise
  
  module Models

    module Capturable

      def self.included(base)
        base.class_eval do
          extend ClassMethods
        end
      end

      # This is called from strategy and is used to fill a user model before saving
      # It defaults to just setting the uuid, but you can override this in your user model
      def set_capturable_params(capture_data)
        self.email = capture_data["email"]
      end

      module ClassMethods

        def capturable_auto_create_account?
          self.capturable_auto_create_account
        end

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
