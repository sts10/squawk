class Tweet < ActiveRecord::Base

  def self.extract_urls(string)
    https = /https?:\/\/[\S]+/
    secure_links = string.scan(https) 
    return secure_links
  end

  def self.make_twitter_client(token, secret)
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key             # "YOUR_CONSUMER_KEY"
      config.consumer_secret     = Rails.application.secrets.twitter_api_secret          # "YOUR_CONSUMER_SECRET"
      config.access_token        = token        # "YOUR_ACCESS_TOKEN"
      config.access_token_secret = secret # "YOUR_ACCESS_SECRET"
    end
  end 


  def self.make_tweet_id_url_array_hash(twitter_client)
    tweet_id_url_array_hash = {}

    @timeline = twitter_client.home_timeline(:count => 170)
    last_id = @timeline.last.id 

    text_array = []
    url_array = []

    @timeline.each do |tweet_obj|
      tweet_id_url_array_hash[tweet_obj.id] = extract_urls(tweet_obj.text) unless extract_urls(tweet_obj.text).empty?
    end

    1.times do 
      @timeline = twitter_client.home_timeline(:count => 170, :max_id => last_id)
      # binding.pry
      last_id = @timeline.last.id 

      @timeline.each do |tweet_obj|
        tweet_id_url_array_hash[tweet_obj.id] = extract_urls(tweet_obj.text)
      end 
    end
    return tweet_id_url_array_hash
  end

  def self.tweet_id_to_object(tweet_id, twitter_client)
    twitter_client.status(tweet_id)
  end


  def self.make_url_objs(twitter_client)
  
    url_obj_array = []
    url_was_old = false

    tweet_id_url_array_hash = Tweet.make_tweet_id_url_array_hash(twitter_client)
    tweet_id_url_array_hash.each do |tweet_id, url_array|
      # binding.pry
  
      url_array.each do |url|
        if url_obj_array != []
          url_obj_array.each do |url_obj|
            if url_obj.address == url
              url_obj.appearances = url_obj.appearances + 1
              url_obj.add_tweet_obj(tweet_id_to_object(tweet_id, twitter_client))
              url_was_old = true
              break
            end
          end
          if !url_was_old
            new_url_obj = Url.new
            new_url_obj.address = url
            new_url_obj.appearances = 1
            new_url_obj.add_tweet_obj(tweet_id_to_object(tweet_id, twitter_client))
            url_obj_array << new_url_obj
          end
        else
          new_url_obj = Url.new
          new_url_obj.address = url
          new_url_obj.appearances = 1
          new_url_obj.add_tweet_obj(tweet_id_to_object(tweet_id, twitter_client))
          url_obj_array << new_url_obj
          
        end
      end
    end
    return url_obj_array.sort_by{|url_obj| url_obj.appearances}.reverse
  end

end
  


