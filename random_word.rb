require 'nokogiri'
require 'rest-client'

req_cookies = {
  "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  "Accept-Encoding" => "gzip, deflate",
  "Accept-Language" => "en-US,en;q=0.5",
  "Connection" => "keep-alive",
  "Host" => "www.oed.com",
  "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:32.0) Gecko/20100101 Firefox/32.0"
}

# attempt = 0
words = []

while words.empty? do
  # puts "Attempt #{attempt += 1}"

  response = RestClient.get('www.oed.com', req_cookies)

  # p response.code
  # p response.cookies
  # p response.headers
  # p response.to_str

  doc = Nokogiri::HTML response.to_str
  # If we get lucky, this is equal to Provisional_Authentication and we'll get words!
  # p response.cookies['acctname']
  words = doc.xpath("//div[@id='lostForWords']//a")
end

words.each { |w| puts w.text }