
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