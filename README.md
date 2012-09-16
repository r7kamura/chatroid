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
    post "Hello"
  end

  on_message /^Hi/ do |event|
    post "Hi!"
  end

  on_reply do |event|
    post "Hi!", :to => event
  end

  on_reply /^Nice to meet you/ do |event|
    post "Nice to meet you too", :to => event
  end

  on_join do |event|
    post "Nice to meet you, #{event.username}", :to => event
  end
end.run!
```

## API

In the block of Chatroid.new, you can call following instance methods.

* set
* post
* on_xxx

xxx can be anything, and the adapter class for the specified service trigger on_xxx properly.
