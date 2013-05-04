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
      def set_capturable_params(params)
        self.email = params["email"]
      end

      module ClassMethods

        # Configuration params accessible within +Devise.setup+ procedure (in initalizer).
        #
        #   Devise.setup do |config|
        #     config.capturable_auto_create_account = true
        #   end
        ::Devise::Models.config(self, :capturable_auto_create_account)

        def capturable_auto_create_account?
          self.capturable_auto_create_account
        end

        # This is called from strategy and is used to find a user when returning from janrain
        # It defaults to find_by_uuid, but you can override this in your user model
        def find_with_capturable_params(params)
          self.find_by_email(params["email"])
        end

        protected

        def valid_for_capturable(resource, attributes)
          true
        end

      end

    end
  end
end
