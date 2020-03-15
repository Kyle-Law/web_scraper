require_relative './scraper.rb'
require 'nokogiri'
require 'httparty'

# Parsing jobs from remote.io up to 100 jobs
class RemoteIoScraper < Scraper
  attr_accessor :url

  def initialize(num_array)
    @num_array = num_array
    @result = ['Title,Company,Skills,Day_posted,URL']
    @url = 'https://www.remote.io/remote-jobs?s='
    @num_url = %w[ruby javascript ruby-on-rails reactjs python java php kubernetes docker flask]
  end

  def scrap
    puts "Keywords selected are #{@num_array.map { |n| @num_url[n] }.join(' & ')}"
    @url = url_maker(@num_array)
    page_start_num = (1..5).to_a # limit to 100 jobs
    scraping_page(page_start_num)
    # sorted = [@result[0]] + @result[1..-1].sort_by { |str| str.split(',')[-1][0, 4].to_i }
    write('remote_io.csv', @result, 'jobs')
  end

  private

  def url_maker(arr)
    @url + arr.map { |n| @num_url[n] }.join(',')
  end

  def add_job(arr)
    arr.each do |card|
      title = card.css('h3.job-listing-title').text.delete(',')
      company = card.css('div.job-listing-footer').text.split('  ')[2].delete(',')
      skills = card.css('div.job-listing-footer').text.split('  ')[4]
      day_posted = card.css('div.job-listing-footer').text.split('  ')[3].delete(',').match(/\d+ \w+ ago/)
      url = 'https://www.remote.io/' + card.css('a')[0].attributes['href'].value
      @result << "#{title},#{company},#{skills},#{day_posted},#{url}"
    end
  end

  def scraping_page(page_array)
    page_array.each do |page|
      page_url = @url + "&p=#{page}"
      jobs_listings = parsing_page(page_url).css('div.job-listing-description')
      break if jobs_listings.empty?

      add_job(jobs_listings)
      puts "#{@result.length - 1} jobs have been scraped from remote.io..."
    end
  end
end
