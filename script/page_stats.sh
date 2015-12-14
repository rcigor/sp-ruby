#!/usr/bin/env ruby
$:.unshift "./lib"

require 'web_traffic_analyser/web_traffic_analyser'
require 'web_traffic_analyser/log_reader'

if ARGV.empty?
  puts 'Filename required'
  exit
end

filename = ARGV.first

reader   = WebTrafficAnalyser::LogReader.new
analyser = WebTrafficAnalyser::WebTrafficAnalyser.new(reader.entries_from_file(filename))

puts "\nTop visited webpages"
analyser.most_visited.each do |page_view|
  puts "#{page_view.page}   #{page_view.hits} visits"
end

puts "\nList of webpages with most unique page views"
analyser.most_unique_page_views.each do |page_view|
  puts "#{page_view.page}   #{page_view.unique_hits} visits"
end
