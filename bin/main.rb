#!/usr/bin/env ruby

require_relative '../lib/Scraper.rb'

puts "Which website do you want to scrap? (udacity / indeed / remote.io)"

loop do 
    $input = gets.chomp
    break if ["udacity","indeed","remote.io"].include?($input)
    puts "Error! Please enter one of the following: udacity / indeed / remote.io"
end

website = ($input.gsub(".","") + "_scraper").to_sym
scrap = Scraper.new
scrap.send(website)