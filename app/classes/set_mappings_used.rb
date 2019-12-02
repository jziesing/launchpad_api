# frozen_string_literal: true

class SetMappingsUsed
  include HTTParty
  base_uri "https://launchpad-accelerator.herokuapp.com"

  attr_reader :mappings_used

  def initialize(mappings_used)
    @mappings_used = mappings_used
  end

  def call
    options = {
      body: {
        app: {
          license_key: ENV["LAUNCHPAD_LICENSE_KEY"],
          mappings_used: mappings_used,
        }
      }      
    }
    
    self.class.put("/set-mappings-used.json", options)
  end
end