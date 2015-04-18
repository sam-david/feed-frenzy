module SoundcloudApi
	def self.start(bpm_playlist)
		# client = Soundcloud.new(:access_token => ENV['SOUNDCLOUD_CLIENT_ID'])
		client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'],
                        :client_secret => ENV['SOUNDCLOUD_CLIENT_SECRET'],
                        :redirect_uri => 'http://localhost:9393/bpm')
		final_playlist = []
		bpm_playlist.each_with_index do |track,index|
			final_track = {}
			if index < 20
				sleep 0.2
				search_query = "#{track['song']} #{track['artist']}" 
				new_track = client.get('/tracks', :q => "#{search_query}", :licence => 'cc-by-sa')
				if new_track == []
					p "no matches found"
					final_track["song"] = track["song"]
					final_track["artist"] = track["artist"]
					final_playlist << final_track
				else
					p track
					if new_track.first.uri != nil
						final_track["uri1"] = new_track.first.uri
					end
					if new_track.length > 2
						final_track["uri2"] = new_track.second.uri
					end
					if new_track.length > 3
						final_track["uri3"] = new_track.third.uri
					end
					final_track["song"] = track["song"]
					final_track["artist"] = track["artist"]
					final_track["artwork_url"] = new_track.first.artwork_url
					final_playlist << final_track
				end
			end
			
		end
		final_playlist
	end
	def self.search_track(query)
		track_list = []
		client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'],
                        :client_secret => ENV['SOUNDCLOUD_CLIENT_SECRET'],
                        :redirect_uri => 'http://localhost:9393/bpm')
		new_track = client.get('/tracks', :q => "#{query}", :licence => 'cc-by-sa')
		# p new_track.first
		new_track.each do |track|
			track_list.push({title: track.title, artist: track.user.username, artwork: track.artwork_url, count: track.playback_count})
		end
		return track_list.sort_by! {|track| track[:count]}.reverse
	end

end