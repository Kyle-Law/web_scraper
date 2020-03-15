require_relative './scraper.rb'
require 'nokogiri'
require 'httparty'

class UdacityScraper < Scraper
  attr_accessor :url

  def initialize(url)
    @url = url
    @result = ['Course Name,Skills Covered,Difficulty,Schoool,URL']
  end

  def scrap
    parsed_page = parsing_page(@url)
    course_listings = parsed_page.css('div.card-content')
    add_course(course_listings)
    write('udacity_courses.csv', @result, 'courses')
  end

  private

  def add_course(arr)
    arr.each do |card|
      course_name = card.css('a.capitalize').text.gsub(',', ' ')
      skills_covered = card.css('span.truncate-content').text.gsub(',', ' ')
      difficulty = card.css('span.capitalize').text
      school = card.css('h4.category').text
      url = 'https://www.udacity.com' + card.css('a.capitalize')[0].attributes['href'].value
      @result << "#{course_name},#{skills_covered},#{difficulty},#{school},#{url}"
    end
  end
end
