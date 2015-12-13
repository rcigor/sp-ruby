#!/usr/bin/env ruby
$:.unshift "./lib"

require 'log_analyser/log_analyser'
require 'log_analyser/log_reader'

if ARGV.empty?
  puts 'Filename required'
  exit
end

filename = ARGV.first

reader   = LogAnalyser::LogReader.new
analyser = LogAnalyser::LogAnalyser.new(reader.entries_from_file(filename))

puts "\nTop visited webpages"
analyser.most_visited.each do |page_view|
  puts "#{page_view.page}   #{page_view.hits} visits"
end

puts "\nList of webpages with most unique page views"
analyser.most_unique_page_views.each do |page_view|
  puts "#{page_view.page}   #{page_view.unique_hits} visits"
end
