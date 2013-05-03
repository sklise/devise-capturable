class API
  include HTTParty
  def initialize(app_name)
    self.base_uri "https://#{app_name}.janraincapture.com"
  end

end