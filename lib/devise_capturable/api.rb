require 'httparty'

module Devise
  module Capturable
    
    class API

      include HTTParty
      format :json
      #debug_output $stderr
    
      def self.token(code)
        redirect_uri = Devise.capturable_redirect_uri || 'http://stupidsettings.com'

        post("#{Devise.capturable_server}/oauth/token", :query => {
          code: code,
          redirect_uri: redirect_uri,
          grant_type: 'authorization_code',
          client_id: Devise.capturable_client_id,
          client_secret: Devise.capturable_client_secret,
        })
      end
    
      def self.entity(token)
        post("#{Devise.capturable_server}/entity", headers: { 'Authorization' => "OAuth #{token}" })
      end
    end

  end
end

