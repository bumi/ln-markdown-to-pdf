require 'kramdown'
require 'prawn'
require 'prawn/table'
require 'sinatra/base'

class Converter < Sinatra::Base

  post "/pdf" do
    content_type :pdf
    document = request.body.read
    Kramdown::Document.new(document).to_pdf
  end

  post "/html" do
    content_type :html
    document = request.body.read
    Kramdown::Document.new(document).to_html
  end

end
