require_relative 'spec_helper'
require_relative '../lib/scraper.rb'

RSpec.describe 'checking if files are created' do
  it 'should contains indeed_jobs.txt file' do
    expect(File.exist?('indeed_jobs.csv')).to be_truthy
  end
  it 'should contains indeed_jobs.txt file' do
    expect(File.exist?('remote_io.csv')).to be_truthy
  end
  it 'should contains indeed_jobs.txt file' do
    expect(File.exist?('udacity_courses.csv')).to be_truthy
  end
end
