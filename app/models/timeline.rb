class Timeline # < ActiveRecord::Base

  def initialize
    @tweets = []
  end 

  # def extract_urls(string)
  #   https = /https?:\/\/[\S]+/
  #   secure_links = string.scan(https) 
  #   # secure_links.reject!{|link| link.include?("\u2026")}
  #   return secure_links
  # end

  def make_twitter_client(token, secret)
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key             # "YOUR_CONSUMER_KEY"
      config.consumer_secret     = Rails.application.secrets.twitter_api_secret          # "YOUR_CONSUMER_SECRET"
      config.access_token        = token        # "YOUR_ACCESS_TOKEN"
      config.access_token_secret = secret # "YOUR_ACCESS_SECRET"
    end
  end 


  def make_tweets(twitter_client)
    tweet_id_url_array_hash = {}
    i = 0 
    timeline = []

    timeline = twitter_client.home_timeline(:count => 199)
    last_id = timeline.last.id - 1 

    3.times do 
        timeline = timeline + twitter_client.home_timeline(:count => 199, :max_id => last_id)
        i = i + 1
        last_id = timeline.last.id - 1
    end 

    puts "TIMELINE COUNT: #{timeline.count}. Loop executed #{i} times."


    timeline.each do |tweet_obj|
      @tweets << Tweet.new(tweet_obj)
      # tweet_id_url_array_hash[tweet_obj.id] = extract_urls(tweet_obj.text) unless extract_urls(tweet_obj.text).empty?
    end
    # return tweet_id_url_array_hash
    # binding.pry
  end

  # def tweet_id_to_object(tweet_id, twitter_client)
  #   twitter_client.status(tweet_id)
  # end


  def make_url_objs(twitter_client)
  
    url_obj_array = []
    # url_was_old = false

    self.make_tweets(twitter_client)

    @tweets.each do |tweet|
      tweet.url_array.each do |url|

        url_obj = url_obj_array.detect {|url_obj| url_obj.address == url } 
        if url_obj
        # if url_obj_array != [] && url_obj_array.detect {|url_obj| url_obj.address == url }
          # url_obj = url_obj_array.detect {|url_obj| url_obj.address == url }

          url_obj.appearances = url_obj.appearances + 1
          url_obj.add_tweet_obj(tweet)
        else
          new_url_obj = Url.new
    
          new_url_obj.address = url
          
          new_url_obj.appearances = 1
          new_url_obj.add_tweet_obj(tweet)
          url_obj_array << new_url_obj
        end
      end
    end

    filter_url_obj_array(url_obj_array)

    return url_obj_array.sort_by{|url_obj| url_obj.appearances}.reverse
  end

  def filter_url_obj_array(url_obj_array)
    url_obj_array.select!{ |url_obj| url_obj.appearances > 1 }

    # loop to weed out same user tweeting the same link twice
    url_obj_array.each do |url_obj|
      url_users = []
      url_obj.tweet_objs.each do |tweet_obj|
        if url_users.include?(tweet_obj.user_handle)  # if url_users.count != url_users.uniq.count
          url_obj.tweet_objs.delete(tweet_obj)
          url_obj.appearances = url_obj.appearances - 1
        else
          url_users << tweet_obj.user_handle
        end
      end
    end

    url_obj_array.select!{ |url_obj| url_obj.appearances > 1 }

    return url_obj_array
  end

end 