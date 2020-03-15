require_relative './scraper.rb'
require 'nokogiri'
require 'httparty'

class IndeedScraper < Scraper
  attr_accessor :url

  def initialize(url)
    @url = url
    @result = ['Title,Company,Location,Summary,URL, Day_posted']
  end

  
  def scrap
    parsed_page = parsing_page(@url)
    total_pages = total_pages_finder(parsed_page, 'div.searchCount-a11y-contrast-color')
    pages_append_urls = page_ending_urls(total_pages)
    scrap_per_page(pages_append_urls)
    sorted = sort_by_dates(@result)
    write('indeed_jobs.csv',sorted,'jobs')
  end

  private

  def total_pages_finder(parsed_page, page_css_property)
    parsed_page.css(page_css_property).text[48..50].to_i
  end

  def page_ending_urls(total_pages)
    (0..total_pages).to_a.select { |i| (i % 10).zero? }
  end

  def add_jobs(jobs_listings)
    jobs_listings.each do |listing|
      title = listing.css('a.jobtitle').text.gsub("\n", '').gsub(',', ' ')
      company = listing.css('span.company').text.gsub("\n", '').gsub(',', ' ')
      location = 'remote' # css is 'span.location' if needed
      summary = listing.css('div.summary').text.gsub("\n", '').gsub(',', ' ')
      key_url = listing.css('a')[0].attributes['href'].value[7..-1]
      url = key_url.start_with?('?jk=') ? 'https://www.indeed.com/viewjob' + key_url : ''
      day_posted = listing.css('span.date').text.gsub("\n", '')
      @result << "#{title},#{company},#{location},#{summary},#{url},#{day_posted}"
    end
  end

  def scrap_per_page(urls_arr)
    urls_arr.each do |page|
      each_page_url = @url + "&start=#{page}"
      parsed_page = parsing_page(each_page_url)
      jobs_listings = parsed_page.css('div.jobsearch-SerpJobCard')
      add_jobs(jobs_listings)
      puts "#{@result.length - 1} Ruby-on-Rails jobs have been scraped from indeed.com..."
    end
  end

  def sort_by_dates(arr)
    [arr[0]] + arr[1..-1].sort_by { |str| str.split(',')[-1][0, 2].to_i }
  end

end
