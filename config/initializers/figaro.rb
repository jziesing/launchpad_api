# frozen_string_literal: true

if ENV['LAUNCHPAD_INSTALLED'] == 'true'
  Figaro.require_keys(
    %w(
      DATABASE_URL
      LAUNCHPAD_LICENSE_KEY
    )
  )
end