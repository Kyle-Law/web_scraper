require_relative 'spec_helper'
require_relative '../lib/scraper.rb'

RSpec.describe 'checking if files are created' do
  it 'should contains indeed_jobs.txt file' do
    expect(File.exist?('indeed_jobs.txt')).to be_truthy
  end
  it 'should contains indeed_jobs.txt file' do
    expect(File.exist?('remote_io.txt')).to be_truthy
  end
  it 'should contains indeed_jobs.txt file' do
    expect(File.exist?('udacity_courses.txt')).to be_truthy
  end
end
