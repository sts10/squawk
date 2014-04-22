class Timeline 

  def initialize(token, secret)
    @twitter_client = self.make_twitter_client(token, secret)
    @tweets = []
    @url_objs = []

  end 

  def make_twitter_client(token, secret)
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key      # "YOUR_CONSUMER_KEY"
      config.consumer_secret     = Rails.application.secrets.twitter_api_secret   # "YOUR_CONSUMER_SECRET"
      config.access_token        = token                                          # "YOUR_ACCESS_TOKEN"
      config.access_token_secret = secret                                         # "YOUR_ACCESS_SECRET"
    end
  end 

  def make_tweets
    timeline = []

    timeline = @twitter_client.home_timeline(:count => 199)
    last_id = timeline.last.id - 1 

    4.times do 
      sleep(1)
      timeline = timeline + @twitter_client.home_timeline(:count => 199, :max_id => last_id)
      last_id = timeline.last.id - 1
    end 

    timeline.each do |tweet_obj|
      @tweets << Tweet.new(tweet_obj)
    end
  end

  def make_url_objs
    self.make_tweets

    @tweets.each do |tweet|
      tweet.expanded_urls.each do |url|
        url_obj = @url_objs.detect {|url_obj| url_obj.address == url } 
      
        if url_obj
          url_obj.appearances = url_obj.appearances + 1
          url_obj.add_tweet_obj(tweet)
        else
          new_url_obj = Url.new
          new_url_obj.address = url
          new_url_obj.add_tweet_obj(tweet)
          @url_objs << new_url_obj
        end
      end
    end

    self.filter_url_objs

    @url_objs.sort_by{|url_obj| url_obj.appearances}.reverse
  end

  def filter_url_objs
    @url_objs.select!{ |url_obj| url_obj.appearances > 1 }

    # loop to weed out same user tweeting the same link twice
    @url_objs.each do |url_obj|
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

    @url_objs.select!{ |url_obj| url_obj.appearances > 1 }
  end

  def get_max_appearances(url_obj_array)
    url_obj_array.max_by { |url_obj| url_obj.appearances }.appearances.to_i
  end

end 