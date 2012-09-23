require "chatroid"

Chatroid.new do
  set :service,         "Twitter"
  set :consumer_key,    "..."
  set :consumer_secret, "..."
  set :access_key,      "..."
  set :access_secret,   "..."

  on_tweet do |event|
    if event["text"] =~ /chatroid/
      favorite event
      follow event
    end
  end

  on_reply do |event|
    reply "Hi, i am a chatroid", event
  end
end.run!
