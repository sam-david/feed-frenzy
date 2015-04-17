module BpmTwitter
	def self.twitter_search()
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV['CONSUMER_KEY']
		  config.consumer_secret     = ENV['CONSUMER_SECRET']
		  config.access_token        = ENV['ACCESS_TOKEN']
		  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
		end
		bpm_playlist = []
		bpm_tweets = client.user_timeline(247455247, :count => 100)
		bpm_tweets.each do |tweet|
			new_track = {}
			if /#BpmBreaker/.match(tweet.text) != nil
				new_track["breaker?"] = true
				new_track["song"] = /([^-]*)-([^-]*)-([^-]*)/.match(tweet.text)[2].rstrip.lstrip.chomp(" playing on #BPM").chomp(" #BpmBreaker").gsub(/&amp;/, '&')
				new_track["artist"] = /([^-]*)-([^-]*)-([^-]*)/.match(tweet.text)[1].rstrip.lstrip.chomp(" playing on #BPM").chomp(" #BpmBreaker").gsub(/&amp;/, '&')
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