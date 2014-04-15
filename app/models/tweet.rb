class Tweet < ActiveRecord::Base

  def self.extract_urls(string)
    https = /https?:\/\/[\S]+/
    secure_links = string.scan(https) 
    return secure_links
  end


  def self.make_tweet_id_url_array_hash
    tweet_id_url_array_hash = {}
    @timeline = MY_TWITTER_CLIENT.home_timeline(:count => 170)
    last_id = @timeline.last.id 

    text_array = []
    url_array = []

    @timeline.each do |tweet_obj|
      tweet_id_url_array_hash[tweet_obj.id] = extract_urls(tweet_obj.text) unless extract_urls(tweet_obj.text).empty?
    end

    1.times do 
      @timeline = MY_TWITTER_CLIENT.home_timeline(:count => 170, :max_id => last_id)
      # binding.pry
      last_id = @timeline.last.id 

      @timeline.each do |tweet_obj|
        tweet_id_url_array_hash[tweet_obj.id] = extract_urls(tweet_obj.text)
      end 
    end
    return tweet_id_url_array_hash
  end

  def self.tweet_id_to_object(tweet_id)
    MY_TWITTER_CLIENT.status(tweet_id)
  end

  def self.make_url_count_hash
    @url_count_hash = {}
    Tweet.make_hash.values.each do |url_array|
      url_array.each do |url|
        if @url_count_hash.keys.include?(url)
          @url_count_hash[url] = @url_count_hash[url] + 1
        else
          @url_count_hash[url] = 1
        end
      end
    end
    # binding.pry
    return @url_count_hash
  end

  # sort a hash by its values, descending (http://stackoverflow.com/questions/4264133/descending-sort-by-value-of-a-hash-in-ruby): 
  # url_count_hash.sort_by {|k,v| v}.reverse

end 