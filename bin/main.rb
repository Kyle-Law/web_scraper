#!/usr/bin/env ruby

require_relative '../lib/Udacity_Scraper.rb'
require_relative '../lib/Indeed_Scraper.rb'

puts "Which website do you want to scrap? (udacity / indeed)"
website = (gets.chomp + "_scraper").to_sym

scrap = Scraper.new
scrap.send(website)
# scrap.udacity_scraper