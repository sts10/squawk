class Tweet < ActiveRecord::Base

  def self.extract_urls(string)
    https = /https?:\/\/[\S]+/
    secure_links = string.scan(https) 
    return secure_links
  end



  def self.get_tweets
    @timeline = MY_TWITTER_CLIENT.home_timeline(:count => 10)
    last_id = @timeline.last.id 

    text_array = []
    url_array = []

    @timeline.each do |tweet_obj|
      text_array << tweet_obj.text
      url_array << extract_urls(tweet_obj.text)
    end 

    1.times do 
      @timeline = MY_TWITTER_CLIENT.home_timeline(:count => 10, :max_id => last_id)
      # binding.pry
      last_id = @timeline.last.id 

      @timeline.each do |tweet_obj|
        text_array << tweet_obj.text
        # url_array << extract_mentioned_screen_names("Best website http://google.com @brianpisano87")
        url_array << extract_urls(tweet_obj.text)
      end 
    end  
    return url_array
  end 


  def self.make_hash
    hash = {}
    @timeline = MY_TWITTER_CLIENT.home_timeline(:count => 10)
    last_id = @timeline.last.id 

    text_array = []
    url_array = []

    @timeline.each do |tweet_obj|
      hash[tweet_obj.id] = extract_urls(tweet_obj.text) unless extract_urls(tweet_obj.text).empty?
    end

    1.times do 
      @timeline = MY_TWITTER_CLIENT.home_timeline(:count => 10, :max_id => last_id)
      # binding.pry
      last_id = @timeline.last.id 

      @timeline.each do |tweet_obj|
        hash[tweet_obj.id] = extract_urls(tweet_obj.text)
      end 
    end
    return hash
  end

  def self.tweet_id_to_object(tweet_id)
    MY_TWITTER_CLIENT.status(tweet_id)
  end

  def self.make_final_hash
    @final_hash = {}
    Tweet.make_hash.each do |url_array|
      url_array.each do |url|
        if @final_hash.keys.include?(url)
          @final_hash[url] = @final_hash[url] + 1
        else
          @final_hash[url] = 1
        end
      end
    end
    binding.pry
    return @final_hash
  end

end 