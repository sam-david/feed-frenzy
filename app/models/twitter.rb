module BpmTwitter
	def self.twitter_search()
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV['CONSUMER_KEY']
		  config.consumer_secret     = ENV['CONSUMER_SECRET']
		  config.access_token        = ENV['ACCESS_TOKEN']
		  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
		end
		p 'bpm_playlist'
		bpm_array = client.user_timeline(247455247)
		p bpm_array
		# p 'bieber'
		# client.search("to:justinbieber marry me", result_type: "recent").take(3).collect do |tweet|
		# 	p "#{tweet.user.screen_name}: #{tweet.text}"
		# end

	end

end