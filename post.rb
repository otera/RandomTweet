#coding:utf-8

require 'rubygems'
require 'user_stream'
require 'twitter'

#アカウント情報
consumer_key = 'hogehoge'
consumer_secret = 'hogehoge'
oauth_token = 'hogehoge'
oauth_token_secret = 'hogehoge'

#ツイートメソッド
def update(tweet)
    begin
        tweet = (tweet.length > 140) ? tweet[0..139].to_s : tweet
        Twitter.update(tweet.chomp)
    rescue => e
        puts e.message
    end
end

UserStream.configure do |config|
    config.consumer_key = consumer_key
    config.consumer_secret = consumer_secret
    config.oauth_token = oauth_token
    config.oauth_token_secret = oauth_token_secret
end

Twitter.configure do |config|
    config.consumer_key = consumer_key
    config.consumer_secret = consumer_secret
    config.oauth_token = oauth_token
    config.oauth_token_secret = oauth_token_secret
end

client = UserStream.client

# 発言集post.datを読み込み、行数を調べる
max = 0
open("post.dat",'r:utf-8') {|file|
    while file.gets
        max += 1
    end
}

#発言集からランダムに1行選んでツイートする
rand = rand(max)
open("post.dat",'r:utf-8'){ |file|
    update(file.readlines[rand])
}