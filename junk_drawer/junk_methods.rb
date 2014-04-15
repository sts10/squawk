
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











def self.make_url_count_hash
  @url_count_hash = {}
  Tweet.make_tweet_id_url_array_hash.values.each do |url_array|
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



def self.get_tweets_from_url_count_hash
  tweets = []
  @url_count_hash.keys.each do |url| 
    make_tweet_id_url_array_hash.each do |tweet_id, url_hash|
      if url_hash.include?(url)
        tweets << tweet_id
      end
    end
  end
  
  return tweets
end




def self.get_tweets_from_one_url(url)
  tweets = []
  make_tweet_id_url_array_hash.each do |tweet_id, url_hash|
    if url_hash.include?(url)
      tweets << tweet_id
    end
  end
  return tweets
end