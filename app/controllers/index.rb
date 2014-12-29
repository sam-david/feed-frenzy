get '/cycling' do
  # Look in app/views/index.erb
  Rss.cyclying_rss
  @race = []
  erb :index
end
