require "rack/lightning"
require_relative "converter"

map "/" do
  run Proc.new { |env| ['301', {'Location' => 'https://github.com/bumi/ln-markdown-to-pdf#readme'}, ['https://github.com/bumi/ln-markdown-to-pdf#readme']] }
end

map "/convert" do
  use Rack::Lightning, { credentials: ENV['LND_CREDENTIALS'], macaroon: ENV['LND_MACAROON'], address: ENV['LND_ADDRESS'] }
  run Converter
end
