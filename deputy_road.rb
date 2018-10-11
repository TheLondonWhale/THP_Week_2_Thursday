require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'CSV'

root = "http://www2.assemblee-nationale.fr"
main_page = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"

def get_the_infos(url)
 page = Nokogiri::HTML(open(url))
 contact = {}
 contact[:first_name] = page.xpath('//*[@id="haut-contenu-page"]/article/div[2]/h1').text.split[1]
 contact[:last_name] = page.xpath('//*[@id="haut-contenu-page"]/article/div[2]/h1').text.split[2]
 contact[:email] = page.xpath('//*[@id="deputes-contact"]/section/dl/dd[1]/a/@href').text.split(":")[1]
 contact
end


def get_deputy_url(root, main_page)
  list_of_urls = []
  page = Nokogiri::HTML(open(main_page))
  page.xpath("//*[@id='deputes-list']/div/ul/li/a/@href").each do |url|
    link = root + url.text
    list_of_urls << link
    end
  list_of_urls
  end

def get_the_deputy (root, main_page)
  list_of_deputy = []
  names = get_deputy_url(root, main_page)
  names.each do |link|
    p deputy = get_the_infos(link)
    list_of_deputy << deputy
  end
return list_of_deputy
end

get_the_deputy(root, main_page)



=begin
//*[@id="deputes-list"]/div/ul/li/a/@href


def get_deputy_url (main_page)
list_of_urls = []
page = Nokogiri::HTML(open(main_page))

p url
=end
