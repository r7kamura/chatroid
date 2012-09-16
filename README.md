# Chatroid
Chatroid is a gem for quickly creating chatterbot in Ruby.

## Installation

```
$ gem "chatroid"
```

## Example
You can create your own bot working in a chat service.

```ruby
require "chatroid"

Chatroid.new do
  set :service,         "Twitter"
  set :consumer_key,    "..."
  set :consumer_secret, "..."
  set :access_key,      "..."
  set :access_secret,   "..."

  on_message do |event|
    if event["text"] =~ /yunotti/
      post "✘╹◡╹✘"
    end
  end

  on_reply do |event|
    post "me too", :to => event
  end
end.run!
```

## Adapters
Currently following services are supported:

* Twitter
* HipChat(WIP)
