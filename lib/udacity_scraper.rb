require_relative './scraper.rb'
require 'nokogiri'
require 'httparty'

class UdacityScraper < Scraper
  attr_accessor :url

  def initialize(url)
    @url = url
    @result = ['Course Name,Skills Covered,Difficulty,Schoool']
  end

  def scrap
    parsed_page = parsing_page(@url)
    course_listings = parsed_page.css('div.card-content')
    course_listings.each do |listing|
      course_name = listing.css('a.capitalize').text.gsub(',', ' ')
      skills_covered = listing.css('span.truncate-content').text.gsub(',', ' ')
      difficulty = listing.css('span.capitalize').text
      school = listing.css('h4.category').text
      @result << "#{course_name},#{skills_covered},#{difficulty},#{school}"
    end
    File.write('udacity_courses.csv', @result.join("\n"))
    puts "udacity_courses.csv file is created at the root directory with #{@result.length - 1} udacity courses"
  end
end
