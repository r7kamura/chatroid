require "chatroid"

Chatroid.new do
  set :service,         "Twitter"
  set :filter,          "chatroid,Chatroid"
  set :consumer_key,    "..."
  set :consumer_secret, "..."
  set :access_key,      "..."
  set :access_secret,   "..."

  on_tweet do |event|
    favorite event
  end

  on_reply do |event|
    favorite event
  end
end.run!
