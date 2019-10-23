# frozen_string_literal: true

class ValidateLicenseKey
  include HTTParty
  base_uri "https://launchpad-accelerator.herokuapp.com"

  def initialize; end

  def call
    options = {
      body: {
        app: {
          license_key: ENV["LAUNCHPAD_LICENSE_KEY"],
        }
      }      
    }
    
    self.class.post("/check-key.json", options)
  end
end