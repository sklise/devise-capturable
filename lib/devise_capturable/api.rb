require 'httparty'

module Devise
  module Capturable
    
    class API

      include HTTParty
      format :json
      debug_output $stderr
    
      def self.token(code)
    
        post("#{Devise.capturable_endpoint}/oauth/token", :query => {
          code: code,
          redirect_uri: "http://stupidsettings.com",
          grant_type: 'authorization_code',
          client_id: Devise.capturable_client_id,
          client_secret: Devise.capturable_client_secret,
        })
      end
    
      def self.entity(token)
        post("#{Devise.capturable_endpoint}/entity", headers: { 'Authorization' => "OAuth #{token}" })
      end
    end

  end
end

