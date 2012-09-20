# Chatroid
Chatroid is a gem for quickly creating chatterbot in Ruby.

## Installation

```
$ gem "chatroid"
```

## Example
Let's create your own bot working in a chat service, and let bot do it!

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

```ruby
require "chatroid"

Chatroid.new do
  set :service,  "HipChat"
  set :room,     "12345_example@conf.hipchat.com"
  set :jid,      "12345_67890@chat.hipchat.com"
  set :nick,     "example"
  set :password, "..."

  on_message do |time, nick, text|
    if text =~ /([\w-.]+@[\w-.]+)/
      invite $1
    end
  end

  on_private_message do |time, nick, text|
    say "Hi, #{nick}"
  end
end.run!
```

## Adapters
* Twitter
* HipChat
* IRC (in the planning stage, sorry)
