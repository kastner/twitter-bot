#!/usr/bin/env ruby

require 'rubygems'
require 'xmpp4r-simple'
require 'twitter'
require 'syslog'

class TwitterBot < Jabber::Simple
  
  TWITTER_JABBER = "twitter@twitter.com"
  
  def self.log(message)
    Syslog.open($0, Syslog::LOG_PID | Syslog::LOG_CONS) { |s| s.warning message }
  end
  
  def initialize(twitter_username, twitter_password, jabber_account, jabber_password)
    @twitter = Twitter::Base.new(twitter_username, twitter_password)
    super(jabber_account, jabber_password)
  end
  
  def log(message)
    TwitterBot.log(message)
  end
  
  def say(message)
    deliver(TWITTER_JABBER, message)
  end
  
  def direct_message(to, message)
    deliver(TWITTER_JABBER, "d #{to} #{message}")
  end
  
  def user(id_or_screen_name)
    @twitter.user(id_or_screen_name)
  end
end
