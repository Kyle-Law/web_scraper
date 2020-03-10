#!/usr/bin/env ruby

require_relative '../lib/Scraper.rb'

puts "Which website do you want to scrap? (udacity / coursera)"
website = (gets.chomp + "_scraper").to_sym

scrap = Scraper.new
scrap.send(website)
# scrap.udacity_scraper