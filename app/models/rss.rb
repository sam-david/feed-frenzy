require 'rss'
require 'open-uri'
require 'uri'

module Rss
	imesh = 'http://www.imesh.com/music/topSongs.html' #html to top songs, nokogiri?
	artistdirect = 'http://www.artistdirect.com/nad/rss/top100/0,,,00.xml' # top artists and downloads if this works
	itunes_top_100 = 'https://itunes.apple.com/us/rss/topsongs/limit=100/xml'
	mtvnews = 'http://www.mtv.com/overdrive/rss/news.jhtml'
	# url = 'http://www.imesh.com/music/topSongs.html'

	def self.cyclying_rss()
		event_array = []
	  url = 'http://www.ncnca.org/event/feed'
	  doc = Nokogiri::HTML(open(url)) do |config|
  		config.strict.nonet
		end
		doc_hash = {}
	  doc_array = doc.text.split("\n")
	  # doc_array.each_with_index do |line, index|
	  # 	p line.lstrip
	  # 	doc_hash[line] = index
	  # end
	  doc_array.each_with_index do |line, index|
	  	p [index, line]
	  	new_event = {}
	  	second_string = doc_array[index + 1]
	  	third_string = doc_array[index + 2]
	  	if line.lstrip == "ROAD" && second_string != nil && second_string[1] == "R" && third_string[1] != "R"
	  		new_event["category"] = doc_array[index + 1].lstrip
	  		new_event["location_url"] = "https://maps.googleapis.com/maps/api/staticmap?center=#{doc_array[index + 2].lstrip.gsub(' ',',')}&zoom=11&size=200x200"
	  		new_event["posted_date"] = doc_array[index + 3].lstrip
	  		new_event["title"] = doc_array[index + 6].lstrip
	  		new_event["url"] = doc_array[index + 7].lstrip
	  		new_event["date"] = /\d{2}\/\d{2}\/\d{4}/.match(doc_array[index + 8].lstrip).to_s
	  		event_array << new_event
	  	end
	  end
	  event_array
	end

	def self.billboard_rss()
		url = 'https://itunes.apple.com/us/rss/topsongs/limit=100/xml'
	  open(url) do |rss|
	    feed = RSS::Parser.parse(rss)
	    puts feed
	    feed.items.each do |item|
	      puts "Item: #{item.title}"
	    end
	  end
	end

end