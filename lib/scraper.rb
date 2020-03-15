require 'nokogiri'
require 'httparty'

class Scraper
  private

  def parsing_page(url)
    Nokogiri::HTML(HTTParty.get(url).body)
  end

  def write(file_name, arr, subject)
    File.write(file_name, arr.join("\n"))
    puts "#{file_name} file is created at the root directory with #{@result.length - 1} #{subject}."
  end
end
