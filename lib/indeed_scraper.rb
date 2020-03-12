require_relative './scraper.rb'
require 'nokogiri'
require 'httparty'

class IndeedScraper < Scraper
  attr_accessor :url

  def initialize(url)
    @url = url
    @result = []
  end

  def scrap
    parsed_page = parsing_page(@url)
    total_pages = parsed_page.css('div.searchCount-a11y-contrast-color').text[48..50].to_i
    page_start_num = (0..total_pages).to_a.select { |i| (i % 10).zero? }
    page_start_num.each do |start|
      url = @url + "&start=#{start}"
      parsed_page = parsing_page(url)
      jobs_listings = parsed_page.css('div.jobsearch-SerpJobCard')
      jobs_listings.each do |listing|
        @result << { title: listing.css('a.jobtitle').text,
                     company: listing.css('span.company').text,
                     location: listing.css('span.location').text,
                     summary: listing.css('div.summary').text.gsub("\n", '-'),
                     day_posted: listing.css('span.date').text }
      end
      puts "#{@result.length} jobs have been scraped..."
    end
    sorted = @result.sort_by { |hash| hash[:day_posted] }
    File.write('indeed_jobs.txt', sorted.join("\n"))
    puts "indeed_jobs.txt file is created at the root directory with #{@result.length} jobs."
  end
end
