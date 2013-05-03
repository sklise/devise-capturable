require 'httparty'

module Capturable

	class API
		
    # This makes it possible to set use the API like this:
    # Capturable::API.endpoint = "http://something.com"
    # Capturable::API.client_id = "thisis"
    # Capturable::API.client_secret = "atest"
    # Capturable::API.redirect_url = "http://locahost"
    class << self
      attr_accessor :client_id, :client_secret, :redirect_uri
      def endpoint=(endpoint)
        base_uri endpoint
      end
    end

    include HTTParty
    format :json

  	def self.token(code)
      post("/oauth/token", :query => {
        code: code,
        redirect_uri: @redirect_uri,
        grant_type: 'authorization_code',
        client_id: @client_id,
        client_secret: @client_secret,
      })
    end

  	def self.entity(token)
      post("/entity", headers: { 'Authorization' => "OAuth #{token}" })
    end
	end

end