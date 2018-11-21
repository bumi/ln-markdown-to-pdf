require "rack/lightning"
require_relative "converter"

use Rack::Lightning, { credentials: ENV['LND_CREDENTIALS'], macaroon: ENV['LND_MACAROON'], address: ENV['LND_ADDRESS'] }

run Converter
