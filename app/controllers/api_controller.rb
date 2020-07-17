# frozen_string_literal: true

class ApiController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include RailsUtil::JsonHelper
  
  before_action :authenticate

  def current_user
    # TODO: customized for each app
  end

  private
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == "launchpad" && password == ENV["LAUNCHPAD_LICENSE_KEY"]
      end
    end
end
