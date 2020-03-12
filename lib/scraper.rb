require 'nokogiri'
require 'httparty'

class Scraper
  private

  def parsing_page(url)
    Nokogiri::HTML(HTTParty.get(url).body)
  end
end
