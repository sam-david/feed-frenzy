module Spotify
	def self.oauth_client
		# track object: popularity, name album.name images(objects with {height, url, width})
		client = OAuth2::Client.new(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'], :site => 'https://accounts.spotify.com/authorize')
		p client.auth_code.authorize_url(:redirect_uri => 'http://127.0.0.1:9393/bpm')
			# p RSpotify::authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])
			# p tracks = RSpotify::Track.search('Thriller')
	end

end