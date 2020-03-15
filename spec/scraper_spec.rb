require_relative 'spec_helper'
require_relative '../lib/scraper.rb'
require_relative '../lib/udacity_scraper.rb'
require_relative '../lib/indeed_scraper.rb'
require_relative '../lib/remoteio_scraper.rb'

require 'nokogiri'
require 'httparty'

RSpec.describe Scraper do
  subject { Scraper.new }
  it 'checks if webpage is parsed' do
    expect(subject.send(:parsing_page, 'https://www.udacity.com/courses/all').text.class == String).to be_truthy
  end

  it 'checks if file is written' do
    subject.write('testing.csv', [1, 2, 3, 4, 5], 'tests')
    expect(File.exist?('testing.csv')).to be_truthy
  end
end

RSpec.describe UdacityScraper do
  subject { UdacityScraper.new('https://www.udacity.com/courses/all') }
  it 'should create udacity_courses.csv after invoking #scrap' do
    puts "We're testing if website scrapping from udacity.com works fine..."
    subject.scrap
    expect(File.exist?('udacity_courses.csv')).to be_truthy
  end
end

RSpec.describe IndeedScraper do
  let(:url) { 'https://www.indeed.com/jobs?q=Ruby+On+Rails&l=Remote&rbl=Remote&jlid=aaa2b906602aa8f5&sort=date' }

  subject { IndeedScraper.new(url) }

  it 'should create indeed_jobs.csv after invoking #scrap' do
    puts "We're testing if website scrapping from indeed.com works fine..."
    subject.scrap
    expect(File.exist?('indeed_jobs.csv')).to be_truthy
  end
end

RSpec.describe RemoteIoScraper do
  subject { RemoteIoScraper.new([1, 2, 3]) }
  let(:search_combination) { [1, 2, 3] }
  let(:completed_url) { 'https://www.remote.io/remote-jobs?s=javascript,ruby-on-rails,reactjs' }

  it 'should return a complete url from #url_maker' do
    expect(subject.send(:url_maker, search_combination)).to eql(completed_url)
  end

  it 'should create remote_io.csv after invoking #scrap' do
    puts "We're testing if website scrapping from remote.io works fine..."
    subject.scrap
    expect(File.exist?('remote_io.csv')).to be_truthy
  end
end

RSpec.describe 'checking if files are created' do
  it 'should contains indeed_jobs.csv file' do
    expect(File.exist?('remote_io.csv')).to be_truthy
  end
end
