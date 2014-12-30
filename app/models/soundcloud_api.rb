module SoundcloudApi
	def self.start(bpm_playlist)
		# client = Soundcloud.new(:access_token => ENV['SOUNDCLOUD_CLIENT_ID'])
		client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'],
                        :client_secret => ENV['SOUNDCLOUD_CLIENT_SECRET'],
                        :redirect_uri => 'http://localhost:9393/twitter')
		final_playlist = []
		bpm_playlist.each_with_index do |track,index|
			final_track = {}
			if index < 10
				sleep 0.25
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

end