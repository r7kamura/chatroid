# Chatroid
Chatroid is a gem for quickly creating chatterbot in Ruby.

## Installation

```
$ gem "chatroid"
```

## Supported
* IRC
* Twitter
* xmpp (Google Talk, HipChat, ...)

## Example
For more examples, please see [examples](https://github.com/r7kamura/chatroid/tree/master/examples).

```ruby
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
    end
  end

  on_reply do |event|
    reply "Hi, i am a chatroid", event
  end

  on_time :hour => 12, :min => 0, :sec => 0 do
    tweet "Hello, world!"
  end
end.run!
```

## Deploy to Heroku

```
$ gem install heroku
$ heroku login

$ mkdir bot
$ cd !$
$ echo "bot: bundle exec ruby bot.rb" >> Procfile
$ echo "source :rubygems" >> Gemfile
$ echo "gem 'chatroid'"   >> Gemfile
$ bundle install
$ vim bot.rb

require "chatroid"

Chatroid.new do
  set :service,         "Twitter"
  set :filter,          "chatroid,Chatroid"
  set :consumer_key,    ENV["CONSUMER_KEY"]
  set :consumer_secret, ENV["CONSUMER_SECRET"]
  set :access_key,      ENV["ACCESS_KEY"]
  set :access_secret,   ENV["ACCESS_SECRET"]

  on_tweet do |event|
    favorite event
  end

  on_reply do |event|
    favorite event
  end
end.run!

$ heroku create your_favorite_bot_name --stack cedar
$ heroku config:add CONSUMER_KEY=... CONSUMER_SECRET=... ACCESS_KEY=... ACCESS_SECRET=...
$ git push heroku master
$ heroku ps:scale bot=1
```
