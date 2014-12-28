get '/cycling' do
  # Look in app/views/index.erb
  @race = Rss.cyclying_rss
  erb :index
end
