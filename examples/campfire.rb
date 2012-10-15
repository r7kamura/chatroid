require "chatroid"

Chatroid.new do
  set :service,   "Campfire"
  set :subdomain, "example"
  set :token,     "..."
  set :room_name, "Bots"        # or `set :room_id, 12345`
  on_message do |message|
    speak "Hi #{message.user.name}" if message.user.name != user_info.name
  end
end.run!
