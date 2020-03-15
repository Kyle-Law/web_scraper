#!/usr/bin/env ruby

require_relative '../lib/udacity_scraper.rb'
require_relative '../lib/indeed_scraper.rb'
require_relative '../lib/remoteio_scraper.rb'

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

website = nil

if input == 'udacity'
  url = 'https://www.udacity.com/courses/all'
  website = UdacityScraper.new(url)

elsif input == 'indeed'
  url = 'https://www.indeed.com/jobs?q=Ruby+On+Rails&l=Remote&rbl=Remote&jlid=aaa2b906602aa8f5&sort=date'

  website = IndeedScraper.new(url)
elsif input == 'remote.io'
  puts 'Welcome to webscraper for remote.io :)'
  puts 'The search keywords are as followed'
  puts '-----------------------------------------------------------------'
  puts '0:ruby, 1: javascript,2: ruby-on-rails,3: reactjs,4: python,5: java,6: php,7: kubernetes, 8: docker,9: flask'
  puts '-----------------------------------------------------------------'
  puts 'Please enter number / combination from above list (eg. 124 for javascript, ruby-on-rails, and python)'

  num = nil
  loop do
    num = gets.chomp.split('').map(&:to_i)
    break if num.all? { |i| i <= 9 && i >= 0 }

    # url = gets.chomp
    # break if url.match?(/^(https:..www.remote.io.remote-jobs.s=)/)

    puts 'Error! Please enter a valid search combination'
  end

  website = RemoteIoScraper.new(num)
end

website.scrap
