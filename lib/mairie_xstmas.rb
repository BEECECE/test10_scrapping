require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_townhall_email(url)
	page = Nokogiri::HTML(open(url))
    page.css("td")[7].text
end

def get_all_emails(url)

	page= Nokogiri::HTML(open(url))
	final = Array.new

	link = page.css('a[class=lientxt]')

	link.each {|url|
	hashville = Hash.new
	hashville["town"] = url.text
	hashville["email"] = get_townhall_email("http://annuaire-des-mairies.com" + url['href'][1..-1]), final.push(hashville)
	}

	puts final
end

def perform
	get_all_emails("http://annuaire-des-mairies.com/val-d-oise.html")
end

perform

# essayer sleeper
