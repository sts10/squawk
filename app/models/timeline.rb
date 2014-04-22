class Timeline 

  def initialize
    @tweets = []
  end 

  def make_twitter_client(token, secret)
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key      # "YOUR_CONSUMER_KEY"
      config.consumer_secret     = Rails.application.secrets.twitter_api_secret   # "YOUR_CONSUMER_SECRET"
      config.access_token        = token                                          # "YOUR_ACCESS_TOKEN"
      config.access_token_secret = secret                                         # "YOUR_ACCESS_SECRET"
    end
  end 


  def make_tweets(twitter_client)
    i = 0 
    timeline = []

    timeline = twitter_client.home_timeline(:count => 199)
    last_id = timeline.last.id - 1 

    4.times do 
      sleep(1)
      timeline = timeline + twitter_client.home_timeline(:count => 199, :max_id => last_id)
      i = i + 1
      last_id = timeline.last.id - 1
    end 

    puts "TIMELINE COUNT: #{timeline.count}. Loop executed #{i} times."

    timeline.each do |tweet_obj|
      @tweets << Tweet.new(tweet_obj)
    end
  end

  def tweet_id_to_object(tweet_id, twitter_client)
    twitter_client.status(tweet_id)
  end

  def make_url_objs(twitter_client)
    url_obj_array = []

    self.make_tweets(twitter_client)

    @tweets.each do |tweet|
      tweet.expanded_urls.each do |url|
        url_obj = url_obj_array.detect {|url_obj| url_obj.address == url } 
      
        if url_obj
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
        if url_users.include?(tweet_obj.user_handle) 
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

  def get_max_appearances(url_obj_array)
    url_obj_array.max_by { |url_obj| url_obj.appearances }.appearances.to_i
  end

end 