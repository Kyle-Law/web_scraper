require_relative './scraper.rb'
require 'nokogiri'
require 'httparty'
require 'byebug'

class IndeedScraper < Scraper
  attr_accessor :url

  def initialize(url)
    @url = url
    @result = ['Title,Company,Location,Summary, Day_posted']
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
        title = listing.css('a.jobtitle').text.gsub("\n", ' ').gsub(',', ' ')
        company = listing.css('span.company').text.gsub("\n", ' ').gsub(',', ' ')
        location = 'remote' # css is 'span.location' if needed
        skills = listing.css('div.summary').text.gsub("\n", ' ').gsub(',', ' ')
        day_posted = listing.css('span.date').text.gsub("\n", ' ')
        @result << "#{title},#{company},#{location},#{skills},#{day_posted}"
      end
      puts "#{@result.length - 1} entry level, remote software engineer jobs have been scraped..."
    end
    sorted = [@result[0]] + @result[1..-1].sort_by { |str| str.split(',')[-1][0, 2].to_i }
    File.write('indeed_jobs.csv', sorted.join("\n"))
    puts "indeed_jobs.csv file is created at the root directory with #{@result.length - 1} jobs."
  end
end
