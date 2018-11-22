#!/usr/bin/env ruby

require "faraday"
require "faraday_ln_paywall"

conn = Faraday.new(:url => 'https://lightning-2pdf.herokuapp.com/') do |faraday|
  faraday.use FaradayLnPaywall::Middleware, { max_amount: 100 }
  faraday.adapter  Faraday.default_adapter
end

if ARGV[0].nil?
  puts "usage: ruby client.rb [path to markdown] [format]"
  exit
end
if !File.exists?(ARGV[0])
  puts "file not found: #{ARGV[0]}"
  exit
end

content = File.read(ARGV[0])
format = ARGV[1] || 'html'

puts conn.post("/convert/#{format}", content).body
