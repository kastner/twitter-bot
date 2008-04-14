#!/usr/bin/env ruby

$:.unshift("../")
require 'rubygems'
require 'simple-daemon'
require 'twitter_bot'
require 'YAML'

# require 'ruby-debug'

WORKING_DIR = "/tmp/bingo-bot/"
DEBUG = true

class MyBot < TwitterBot
  def initialize(twitter_username, twitter_password, jabber_account, jabber_password)
    super
    @bot_name = twitter_username
  end
  
  def go
    received_messages { |message| deal_with(message.body) }
  end
  
  def deal_with(message)
    log(message) if DEBUG
    case message
    when /^(.*):\s*@#{@bot_name}:?\s*(.*)\s*$/i # @ reply
      user, command = $1, $2
      log("@reply from #{user} / #{command}") if DEBUG
      handle_reply(user, command)
    when /Direct from (.*):\n([^\n]+)\n/
      user, command = $1, $2
      log("#{user} / #{command}") if DEBUG
      handle_dm(user, command)
    end
  end
  
  def end
    disconnect
  end
end

class BotRunner < SimpleDaemon::Base
  `mkdir -p #{WORKING_DIR}` # just make sure the working dir exists
  SimpleDaemon::WORKING_DIRECTORY = WORKING_DIR
  
  def self.start
    TwitterBot.log("start up") if DEBUG
    initialize_envrionment

    @bot = MyBot.new(@bot_settings["twitter_user"], @bot_settings["twitter_pass"], @bot_settings["jabber_acct"], @bot_settings["jabber_pass"])
    loop do
      begin
        @bot.go
      rescue => e
        TwitterBot.log(e.inspect) if DEBUG
      end
      sleep(2)
    end
  end

  def self.stop
    @bingo.end
  end  
end

def initialize_envrionment
  raise "Missing file #{ENV["HOME"]}/bot.yml" unless File.exists?("#{ENV["HOME"]}/bot.yml")

  @bot_settings = YAML::load_file("#{ENV["HOME"]}/bot.yml")
end

BotRunner.daemonize
