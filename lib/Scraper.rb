require 'nokogiri'
require 'httparty'
require 'byebug'

class Scraper

    def udacity_scraper
        url = 'https://www.udacity.com/courses/all'
        unparsed_page = HTTParty.get(url)
        parsed_page = Nokogiri::HTML(unparsed_page)
        courses = []
        course_listings = parsed_page.css('div.card-content')
        course_listings.each do |listing|
            courses << {
                course_name: listing.css('a.capitalize').text,
                skills_covered: listing.css('span.truncate-content').text,
                difficulty: listing.css('span.capitalize').text
            }
        end
        File.write("udacity_courses.txt",courses.join("\n"))
    end
end

