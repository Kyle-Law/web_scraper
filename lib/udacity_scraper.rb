require_relative './scraper.rb'
require 'nokogiri'
require 'httparty'

class UdacityScraper < Scraper
  attr_accessor :url

  def initialize(url)
    @url = url
    @result = []
  end

  def scrap
    parsed_page = parsing_page(@url)
    course_listings = parsed_page.css('div.card-content')
    course_listings.each do |listing|
      @result << {
        course_name: listing.css('a.capitalize').text,
        skills_covered: listing.css('span.truncate-content').text,
        difficulty: listing.css('span.capitalize').text,
        school: listing.css('h4.category').text
      }
    end
    File.write('udacity_courses.txt', @result.join("\n"))
    puts "udacity_courses.txt file is created at the root directory with #{@result.length} udacity courses"
  end
end
