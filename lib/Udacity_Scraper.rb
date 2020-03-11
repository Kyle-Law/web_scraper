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
                difficulty: listing.css('span.capitalize').text,
                school: listing.css('h4.category').text
            }
        end
        File.write("udacity_courses.txt",courses.join("\n"))
    end

    def indeed_scraper
        url = "https://www.indeed.com/jobs?q=Remote+Web+Developer&rbl=Remote&jlid=aaa2b906602aa8f5&explvl=entry_level"
        unparsed_page = HTTParty.get(url)
        parsed_page = Nokogiri::HTML(unparsed_page)
        total_pages = parsed_page.css('div.searchCount-a11y-contrast-color').text[48..50].to_i
        page_start_num = (0..total_pages).to_a.select{|i| i%10==0}
        jobs = []
        page_start_num.each do |start|
            url = "https://www.indeed.com/jobs?q=Remote+Web+Developer&rbl=Remote&jlid=aaa2b906602aa8f5&explvl=entry_level&start=#{start}"
            unparsed_page = HTTParty.get(url)
            parsed_page = Nokogiri::HTML(unparsed_page)
            jobs_listings = parsed_page.css('div.jobsearch-SerpJobCard')
            jobs_listings.each do |listing|
                if listing.css('span.date').text != "Today"
                    jobs << {
                    title: listing.css('a.jobtitle').text,
                    company: listing.css('span.company').text,
                    location: listing.css('span.location').text,
                    summary: listing.css('div.summary').text.gsub("\n","-"),
                    day_posted: listing.css('span.date').text
                    }
                else
                    jobs << {
                    title: listing.css('a.jobtitle').text,
                    company: listing.css('span.company').text,
                    location: listing.css('span.location').text,
                    summary: listing.css('div.summary').text.gsub("\n","-"),
                    day_posted: "0"
                    }
                end
            end
        end
        # courses.each{|i| puts i}
        sorted = jobs.sort_by{|hash| hash[:day_posted]}
        # byebug
        File.write("indeed_job.txt",sorted.join("\n"))
    end
end

