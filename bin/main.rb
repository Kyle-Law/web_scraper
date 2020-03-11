#!/usr/bin/env ruby

require_relative '../lib/scraper.rb'

title = <<~MLS

  ╦ ╦┌─┐┌┐   ╔═╗┌─┐┬─┐┌─┐┌─┐┌─┐┬─┐
  ║║║├┤ ├┴┐  ╚═╗│  ├┬┘├─┤├─┘├┤ ├┬┘
  ╚╩╝└─┘└─┘  ╚═╝└─┘┴└─┴ ┴┴  └─┘┴└─

  by Kyle Law \u00A9,2020


MLS
puts title
puts 'Welcome to Web Scraper!'
puts 'Which website do you want to scrap? (udacity / indeed / remote.io)'
input = ''
loop do
  input = gets.chomp
  break if ['udacity', 'indeed', 'remote.io'].include?(input)

  puts 'Error! Please enter one of the following: udacity / indeed / remote.io'
end

website = (input.gsub('.', '') + '_scraper').to_sym
scrap = Scraper.new
scrap.send(website)
