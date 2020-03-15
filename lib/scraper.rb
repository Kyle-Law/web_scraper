require 'nokogiri'
require 'httparty'

class Scraper
  def write(file_name, arr, subject)
    File.write(file_name, arr.join("\n"))
    puts "#{file_name} file is created at the root directory with #{arr.length - 1} #{subject}."
  end

  private

  def parsing_page(url)
    Nokogiri::HTML(HTTParty.get(url).body)
  end
end
