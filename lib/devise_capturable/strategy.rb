require 'devise_capturable/api'

module Devise
  
  module Capturable
    
    module Strategies

      class Capturable < ::Devise::Strategies::Base

        def valid?
          valid_controller? && valid_params? && mapping.to.respond_to?(:find_with_capturable_params) && mapping.to.method_defined?(:before_capturable_create) && mapping.to.method_defined?(:before_capturable_sign_in)
        end

        def authenticate!
          klass = mapping.to

          begin
  
            token = Devise::Capturable::API.token(params[:code])
            fail!(:capturable_invalid) unless token['stat'] == 'ok'
              
            entity = Devise::Capturable::API.entity(token['access_token'])
            user = klass.find_with_capturable_params(entity["result"])

            if user
              user.before_capturable_sign_in(entity["result"], params)
            else
              user = klass.new
              user.before_capturable_create(entity["result"], params)
              user.save
            end

            success!(user)

          rescue Exception => e
            fail!(:capturable_invalid)
          end
        end
        
        protected
          
        def valid_controller?
          params[:controller].to_s =~ /sessions/
        end

        def valid_params?
          params[:code].present?
        end

      end
    end
  end
end

