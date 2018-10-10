require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'CSV'

url = "https://coinmarketcap.com/"
page = "all/views/all"

def get_the_value(url)
  crytpo_currencies = {}
  page = Nokogiri::HTML(open(url))
  crytpo_currencies[:name] = page.xpath('/html/body/div[2]/div/div[1]/div[3]/div[1]/h1/text()').text.strip
  crytpo_currencies[:rate] = page.xpath('//*[@id="quote_price"]/span[1]').text
return crytpo_currencies
end

def get_all_the_urls_of_crypto_currencies(url, page)
  list_of_urls = []
  page = Nokogiri::HTML(open(url + page))
  page.xpath("//a[@class = 'link-secondary']/@href").each do |link|
    list_of_urls << url + link.text[1..-1]
  end
return list_of_urls
end


def get_all_crypto(url, page)
  list_of_crypto = []
  names = get_all_the_urls_of_crypto_currencies(url, page)
  names.each do |link|
    p a = get_the_value(link)
    list_of_crypto << a
  end
return list_of_values
end

get_all_crypto(url, page)
