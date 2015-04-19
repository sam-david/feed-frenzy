module SoundcloudApi
	def self.search_track(query)
		track_list = []
		client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'],
                        :client_secret => ENV['SOUNDCLOUD_CLIENT_SECRET'],
                        :redirect_uri => 'http://localhost:9393/bpm')
		new_track = client.get('/tracks', :q => "#{query}", :licence => 'cc-by-sa')
		# p new_track.first
		new_track.each do |track|
			if track.playback_count == nil
				track_list.push({title: track.title, artist: track.user.username, artwork: track.artwork_url, count: 0, uri: track.uri})
			else
				track_list.push({title: track.title, artist: track.user.username, artwork: track.artwork_url, count: track.playback_count, uri: track.uri})
			end
		end
		p track_list
		return track_list.sort_by! {|track| track[:count]}.reverse
	end

end