require "chatroid"

Chatroid.new do
  set :service,  "HipChat"
  set :room,     "12345_example@conf.hipchat.com"
  set :jid,      "12345_67890@chat.hipchat.com"
  set :nick,     "example"
  set :password, "..."

  on_message do |time, nick, text|
    say "Hi, #{nick}" if nick != config[:nick]
  end
end.run!
