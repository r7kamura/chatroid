require "chatroid"

Chatroid.new do
  set :service,  "Irc"
  set :server,   "example.com"
  set :port,     "6667"
  set :channel,  "#chatroid"
  set :username, "chatroid"

  on_privmsg do |message|
    privmsg "#chatroid", ":" + "Hi, i am a chatroid"
  end
end.run!
