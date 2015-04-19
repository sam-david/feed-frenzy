get '/cycling' do
  # Look in app/views/index.erb
  @race = Rss.cyclying_rss
  erb :index
end

get '/music' do
	Rss.billboard_rss
end

get '/bpm' do
	@bpm_playlist = BpmTwitter.twitter_search
	@spotify_link = Spotify.oauth_client
	# @tracks = SoundcloudApi.start(bpm_playlist)
	erb :bpm
end 

get '/search_track' do
	p params[:query]
	content_type :json
	SoundcloudApi.search_track("#{params[:query]}").to_json
end

get '/spotify' do 
	# p artists = RSpotify::Artist.search('Arctic Monkeys')
	Spotify.oauth_client
	erb :spotify
end

get '/auth/spotify/callback' do

end