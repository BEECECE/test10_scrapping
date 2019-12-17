require 'rubygems'
require 'nokogiri'
require 'open-uri'


def getemail (urldeputy)
	page = Nokogiri::HTML(open(urldeputy))
	email = page.xpath('//*[@id="b1"]/ul[2]/li[1]/ul/li/a').text

	nom = page.css('h1').text
	print nom + " : "
	puts email
end

def getallurls()
	#url = "http://www.nosdeputes.fr/" + prenom + "-" + nom
	doc = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))
	div_classes = doc.xpath('//div[@class="list_table"]')
	all_a = div_classes.css('a')   

	allurl = all_a.map{|element| urls = 'https://nosdeputes.fr'+element["href"]}

	# puts allurl

	allurl.each { |url| puts getemail(url) }

end

getallurls
#getemail
