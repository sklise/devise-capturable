require 'httparty'

class CaptureAPI

  include HTTParty
  format :json

	def self.token(code)

    post("#{Devise.capturable_endpoint}/oauth/token", :query => {
      code: code,
      redirect_uri: Devise.capturable_redirect_uri,
      grant_type: 'authorization_code',
      client_id: Devise.capturable_client_id,
      client_secret: Devise.capturable_client_secret,
    })
  end

	def self.entity(token)
    post("/entity", headers: { 'Authorization' => "OAuth #{token}" })
  end
end