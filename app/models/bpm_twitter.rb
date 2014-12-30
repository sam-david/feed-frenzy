module BpmTwitter
	def self.twitter_search()
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV['CONSUMER_KEY']
		  config.consumer_secret     = ENV['CONSUMER_SECRET']
		  config.access_token        = ENV['ACCESS_TOKEN']
		  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
		end
		bpm_playlist = []
		bpm_tweets = client.user_timeline(247455247, :count => 50)
		bpm_tweets.each do |tweet|
			new_track = {}
			if /#BpmBreaker/.match(tweet.text) != nil
				new_track["breaker?"] = true
				p tweet.text
				# new_track["song"] = /^([^-]*)-([^-]*)/.match(tweet.text)[2].rstrip.lstrip.chomp(" playing on #BPM")
				new_track["song"] = /([^-]*)-([^-]*)-([^-]*)/.match(tweet.text)[2].rstrip.lstrip.chomp(" playing on #BPM").chomp(" #BpmBreaker").gsub(/&amp;/, '&')
				new_track["artist"] = /([^-]*)-([^-]*)-([^-]*)/.match(tweet.text)[1].rstrip.lstrip.chomp(" playing on #BPM").chomp(" #BpmBreaker").gsub(/&amp;/, '&')
				# new_track["song"] = /([^-]*)/.match(tweet.text)[3].rstrip.lstrip.chomp(" playing on #BPM")
				# p new_track["song"]
			else
				new_track["breaker?"] = false
				new_track["song"] = /^([^-]*)-([^-]*)/.match(tweet.text)[2].rstrip.lstrip.chomp(" playing on #BPM")
				new_track["artist"] = /^([^-]*)-([^-]*)/.match(tweet.text)[1].rstrip
			end
			bpm_playlist << new_track
		end
		bpm_playlist
	end

end