# frozen_string_literal: true

Figaro.require_keys(
  %w(
    DATABASE_URL
    LAUNCHPAD_LICENSE_KEY
  )
)
