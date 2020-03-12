require_relative './scraper.rb'
require 'nokogiri'
require 'httparty'
require 'byebug'

# Parsing jobs from remote.io up to 100 jobs
class RemoteIoScraper < Scraper
  attr_accessor :url

  def initialize(num_array)
    @num_array = num_array
    @result = ['title,company,skills,day_posted']
    @url = 'https://www.remote.io/remote-jobs?s='
    @num_url = ['', 'javascript', 'ruby-on-rails', 'reactjs', 'python', 'java', 'php', 'kubernetes', 'docker']
  end

  def url_maker(arr)
    @url + arr.map { |n| @num_url[n] }.join(',')
  end

  def scrap
    puts "Keywords selected are #{@num_array.map { |n| @num_url[n] }.join(' & ')}"
    @url = url_maker(@num_array)
    page_start_num = (1..5).to_a # limit to 100 jobs
    page_start_num.each do |page|
      page_url = @url + "&p=#{page}"
      jobs_listings = parsing_page(page_url).css('div.job-listing-description')
      break if jobs_listings.empty?

      jobs_listings.each do |listing|
        @result << {
          title: listing.css('h3.job-listing-title').text.delete(','),
          company: listing.css('div.job-listing-footer').text.split('  ')[2].delete(','),
          skills: listing.css('div.job-listing-footer').text.split('  ')[4].delete(','),
          day_posted: listing.css('div.job-listing-footer').text.split('  ')[3].delete(',')
        }
      end
      puts "#{@result.length - 1} jobs have been scraped..."
    end
    sorted = [@result[0]] + @result[1..-1].sort_by { |hash| hash[:day_posted][0, 4].to_i }
    File.write('remote_io.csv', sorted.join("\n"))
    puts "remote_io.csv file is created at the root directory with #{@result.length - 1} jobs."
  end
end
