require 'nokogiri'
require 'httparty'

class Scraper
  def initialize
    @result = []
    @udacity_url = 'https://www.udacity.com/courses/all'
    @indeed_url = 'https://www.indeed.com/jobs?q=Remote+Web+Developer&rbl=Remote&jlid=aaa2b906602aa8f5&explvl=entry_level'
    @remoteio_url = 'https://www.remote.io/remote-jobs?s=ruby-on-rails'
  end

  

  def udacity_scraper
    parsed_page = parsing_page(@udacity_url)
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

  def indeed_scraper
    parsed_page = parsing_page(@indeed_url)
    total_pages = parsed_page.css('div.searchCount-a11y-contrast-color').text[48..50].to_i
    page_start_num = (0..total_pages).to_a.select { |i| (i % 10).zero? }
    page_start_num.each do |start|
      url = @indeed_url + "&start=#{start}"
      parsed_page = parsing_page(url)
      jobs_listings = parsed_page.css('div.jobsearch-SerpJobCard')
      jobs_listings.each do |listing|
        @result << { title: listing.css('a.jobtitle').text,
                     company: listing.css('span.company').text,
                     location: listing.css('span.location').text,
                     summary: listing.css('div.summary').text.gsub("\n", '-'),
                     day_posted: listing.css('span.date').text }
      end
      puts "#{@result.length} remote jobs have been scraped..."
    end
    sorted = @result.sort_by { |hash| hash[:day_posted] }
    File.write('indeed_jobs.txt', sorted.join("\n"))
    puts "indeed_jobs.txt file is created at the root directory with #{@result.length} jobs."
  end

  def remoteio_scraper
    parsed_page = parsing_page(@remoteio_url)
    total_pages = (parsed_page.css('small').text[1, 3].to_f % 20).round
    page_start_num = (1..total_pages).to_a
    page_start_num.each do |page|
      page_url = @remoteio_url + "&p=#{page}"
      jobs_listings = parsing_page(page_url).css('div.job-listing-description')
      jobs_listings.each do |listing|
        @result << {
          title: listing.css('h3.job-listing-title').text,
          company: listing.css('div.job-listing-footer').text.split('  ')[2],
          skills: listing.css('div.job-listing-footer').text.split('  ')[4],
          day_posted: listing.css('div.job-listing-footer').text.split('  ')[3]
        }
      end
      puts "parsing page #{page}..."
    end
    sorted = @result.sort_by { |hash| hash[:day_posted][0, 4].to_i }
    File.write('remote_io.txt', sorted.join("\n")) unless sorted.empty?
    puts "remote_io.txt file is created at the root directory with #{@result.length} jobs." unless @result.length.zero?
  end

  private
  
  def parsing_page(url)
    Nokogiri::HTML(HTTParty.get(url).body)
  end
end
