require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'CSV'

def get_the_email_of_a_townhal_from_its_webpage(website)
page = Nokogiri::HTML(open(website))
emails = {}
emails['mail_of_cityhall'] = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
emails['name_of_cityhall'] = page.xpath('/html/body/div/main/section[1]/div/div/div/p[1]/strong[1]/a').text
return emails
end


def get_all_the_urls_of_val_doise_townhalls(main_url, website)
list_of_urls = []
page = Nokogiri::HTML(open(website))
page.xpath('//a[@class = "lientxt"]/@href').each do |link|
    url = main_url + link.to_s[1..-1]
    list_of_urls << url
  end
return list_of_urls
end

def get_all_the_mails_of_val_doise_townhalls(main_url, website)
page = Nokogiri::HTML(open(website))
list_of_mails = []
  page.xpath('//a[@class = "lientxt"]/@href').each do |link|
    url = main_url + link.to_s[1..-1]
    list_of_mails << get_the_email_of_a_townhal_from_its_webpage(url)
  end
  list_of_mails
end

get_the_email_of_a_townhal_from_its_webpage('http://annuaire-des-mairies.com/95/vaureal.html') #première méthode qui va cherche l'email d'une mairie sur son site

get_all_the_urls_of_val_doise_townhalls('http://annuaire-des-mairies.com','http://annuaire-des-mairies.com/val-d-oise.html') #va chercher tous les mails de toutes les mairies

p get_all_the_mails_of_val_doise_townhalls('http://annuaire-des-mairies.com','http://annuaire-des-mairies.com/val-d-oise.html') #va chercher tous les mails de toutes les mairies
