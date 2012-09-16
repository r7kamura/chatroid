# Chatroid
Chatroid is a gem for quickly creating chatterbot in Ruby.

## Installation

```
$ gem "chatroid"
```

## Example
You can create your own bot working in a chat service.
The following example creates a bot,
which responds to tweets including the word "yunotti" or any replies to it.

```ruby
require "chatroid"

Chatroid.new do
  set :service,         "Twitter"
  set :consumer_key,    "..."
  set :consumer_secret, "..."
  set :access_key,      "..."
  set :access_secret,   "..."

  on_tweet do |event|
    if event["text"] =~ /yunotti/
      favorite event
      follow event
    end
  end

  on_reply do |event|
    reply "✘╹◡╹✘", event
  end
end.run!
```

## Adapters
Currently following services are supported:

* Twitter

I plan to support following services:

* IRC
* HipChat
