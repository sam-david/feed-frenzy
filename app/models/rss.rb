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
		all_races = []
		all_races << ncnca_parse
		all_races << bikereg_parse
		all_races.flatten.sort_by { |race| race["date"]}
	end

	def self.ncnca_parse()
		ncnca_races = []
	  url = 'http://www.ncnca.org/event/feed'
	  doc = Nokogiri::HTML(open(url)) do |config|
  		config.strict.nonet
		end
		doc_hash = {}
	  doc_array = doc.text.split("\n")
	  doc_array.each_with_index do |line, index|
	  	# if index < 300
	  	# 	p [index, line]
	  	# end
	  	new_event = {}
	  	second_string = doc_array[index + 1]
	  	third_string = doc_array[index + 2]
	  	if line.lstrip == "ROAD" && second_string != nil && second_string[1] == "R" && third_string[1] != "R"
	  		new_event["source"] = "ncnca"
	  		new_event["category"] = doc_array[index + 1].lstrip
	  		new_event["location_url"] = "https://www.google.com/maps/embed/v1/place?key=AIzaSyBlEY-VyF62JB4Ouo1z69JlqNgvg421YXU
      &q=#{doc_array[index + 2].lstrip.gsub(' ',',')}"
	  		new_event["posted_date"] = doc_array[index + 3].lstrip
	  		new_event["title"] = doc_array[index + 6].lstrip
	  		new_event["url"] = doc_array[index + 7].lstrip
	  		new_event["date"] = /\d{2}\/\d{2}\/\d{4}/.match(doc_array[index + 8].lstrip).to_s
	  		ncnca_races << new_event
	  	end
	  end
	   
	  ncnca_races
	end

	def self.ncnca_race_parse()
		race_page = Nokogiri::HTML(open("http://www.ncnca.org/ncncaevent/early-bird-criterium-training-series-2-2"))
		p "*******************************************"
		race_lines = race_page.text.split("\n")
		race_lines.each do |line|
			p line
		end
	end

	def self.bikereg_parse()
		url = 'https://www.bikereg.com/events/CalendarFeed.aspx?et=1&rg=0&ns=&ne=15&pid=&states=CA&t=rss'
		bikereg_races = []
		open(url) do |rss|
  		feed = RSS::Parser.parse(rss)
  		feed.items.each do |item|
  			new_event = {}
  			new_event["source"] = "BikeReg"
  			new_event["title"] = item.title
  			new_event["url"] = item.link
  			new_event["categories"] = bikereg_race_parse(item.link)
  			# unformatted_date = /\d{1,2}\/\d{1,2}\/\d{2,4}/.match(item.title).to_s
  			# parsed_date = Date._parse(unformatted_date)
  			# new_event["date"] = "#{parsed_date[:mon]}/#{parsed_date[:mday]}/#{parsed_date[:year]}"
  			new_event["date"] = /\d{1,2}\/\d{1,2}\/\d{2,4}/.match(item.title).to_s
  			new_event["posted_date"] = item.pubDate
  			bikereg_races << new_event
  		end
		end
		bikereg_races
	end

	def self.bikereg_race_parse(url)
		bikereg_parsed = Nokogiri::HTML(open(url))
		distances = bikereg_parsed.css('.distance').text.split("\n")
		p distances.length
		starts = bikereg_parsed.css('.start').text.split("\n")
		p starts.length
	end

	def self.billboard_rss()
		url = 'https://itunes.apple.com/us/rss/topsongs/limit=100/xml'
	  # open(url) do |rss|
	  #   feed = RSS::Parser.parse(rss)
	  #   feed.items.each do |item|
	  #     puts item.title.to_s
	  #   end
	  # end
	  billboard_parsed = Nokogiri::HTML(open(url)) do |config|
  		config.strict.nonet
		end
	  p titles = billboard_parsed.css('title')
	  # titles.each do |test|
	  # 	p test.text
	  # end
	  # p doc.text.split("\n")
	  # p bikereg_parsed.title
	end

end