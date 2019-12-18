require 'rubygems'
require 'pry'
require 'nokogiri'
require 'open-uri'

URI_CRYPTO = "https://coinmarketcap.com/all/views/all/"
CSS_PATH_CURRENCIES = "tr > td:nth-child(3)"
CSS_PATH_PRICES = "tr > td:nth-child(5) > a:nth-child(1)"

def text_from_css(uri_str, css_select_str)
  collected_texts = []
  Nokogiri::HTML(open(uri_str)).css(css_select_str).each { |node| collected_texts << node.text }
  return collected_texts
end

def format_price(price_str)
  price_str.delete_prefix("$").to_f
end

def crypto_scrapping
  scrapped = []
  currencies = text_from_css(URI_CRYPTO, CSS_PATH_CURRENCIES)
  prices = text_from_css(URI_CRYPTO, CSS_PATH_PRICES)
  currencies.each do |curr|
    collected_to_hash = { curr => format_price(prices[currencies.index(curr)]) }
    scrapped << collected_to_hash
    puts scrapped[currencies.index(curr)]
  end
  return scrapped
end

crypto_scrapping