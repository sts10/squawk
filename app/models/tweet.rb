class Tweet < ActiveRecord::Base

  def self.extract_urls(string)
   
    https = /https?:\/\/[\S]+/
    # http = /http?:\/\/[\S]+/

    secure_links = string.scan(https) # https.match(string).to_a
    # other_links = http.match(string).to_a

    return secure_links
  end



  def self.get_tweets
    
    @timeline = MY_TWITTER_CLIENT.home_timeline(:count => 200)
    last_id = @timeline.last.id 

    text_array = []
    url_array = []

    @timeline.each do |tweet_obj|
      text_array << tweet_obj.text
      url_array << extract_urls(" Best website http://google.com @brianpisano87 https://yahoo.com ")
    end 

    1.times do 
      @timeline = MY_TWITTER_CLIENT.home_timeline(:count => 200, :max_id => last_id)
      # binding.pry
      last_id = @timeline.last.id 

      @timeline.each do |tweet_obj|
        text_array << tweet_obj.text
        # url_array << extract_mentioned_screen_names("Best website http://google.com @brianpisano87")
        # url_array << extract_urls(tweet_obj.text)
      end 
    end  

    return url_array
  end 

end 