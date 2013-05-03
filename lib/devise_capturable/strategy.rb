require 'devise_capturable/api'

module Devise
  
  module Capturable
    
    module Strategies

      class Capturable < ::Devise::Strategies::Base

        def valid?
          valid_controller? && valid_params? && mapping.to.respond_to?('find_with_capturable_params') && mapping.to.respond_to?('new_with_capturable_params')
        end

        def authenticate!
          klass = mapping.to
      
          begin
  
            token = CaptureAPI.token(params[:code])
            raise Exception, "Expired or Unusable Token" unless token['stat'] == 'ok'
              
            entity = CaptureAPI.entity(token['access_token'])
            user = klass.find_with_capturable_params(entity["result"]) 

            if user
              success!(user)
              return
            end

            unless klass.capturable_auto_create_account?
              fail!(:capturable_invalid)
              return
            end
            
            user = klass.new
            # again: maybe the params come wrapped in an object instead of in root params?
            user.set_capturable_params(params)            
            user.save(:validate => false)
            success!(user)
          rescue Exception => e
            puts e.inspect
            fail!(:capturable_invalid)
          end
        end
        
        protected
          
        def valid_controller?
          params[:controller].to_s =~ /sessions/
        end

        def valid_params?
          params[:token].present?
        end

      end
    end
  end
end

