# frozen_string_literal: true

LpTokenAuth.config do |config|
  # The secret used when encrypting the JWT
  #
  config.secret = "2e10f4e6090ac085d61b3f653a36dff1c4091a382aca5c2af99fb1e1d9a6428d5b179976314443e066d325b3b89b40f72ae1337722d38d596c876320645c6202"

  # The number of hours the token is active
  # default: 7 * 24
  #
  config.expires = 7 * 24

  # The encryption algorithm to use
  # default: HS512
  #
  config.algorithm = "HS512"

  # Where to include the token in the response, must be an array, options are
  # :cookie, :header
  # default: [:cookie]
  #
  config.token_transport = [:cookie]
end
