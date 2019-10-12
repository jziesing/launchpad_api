require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Accounts" do
  let(:token) { Base64.strict_encode64("launchpad:#{ENV['LAUNCHPAD_LICENSE_KEY']}") }

  before do
    header "Content-Type", "application/json"
    authentication :basic, "Basic #{token}"
  end

  get "/api/accounts" do
    example "Listing accounts" do
      binding.pry
      do_request

      expect(status).to eq 200
    end
  end
end