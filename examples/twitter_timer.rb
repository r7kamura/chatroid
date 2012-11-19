require "chatroid"

Chatroid.new do
  set :service,         "Twitter"
  set :consumer_key,    "..."
  set :consumer_secret, "..."
  set :access_key,      "..."
  set :access_secret,   "..."

  on_time :hour => 6, :min => 0, :sec => 0 do
    tweet "Good morning!"
  end

  on_time :hour => 0, :min => 0, :sec => 0 do
    tweet "Good night!"
  end

  on_time :day => [10, 20, 30], :hour => 12, :min => 0, :sec => 0 do
    tweet "@chatroid How are you?"
  end
end.run!
