class Tweet < ActiveRecord::Base
  def self.get_tweets
    
    @timeline = MY_TWITTER_CLIENT.home_timeline(:count => 200)

    text_array = []
    @timeline.each do |tweet_obj|
      text_array << tweet_obj.text
    end 

    return text_array
  end 
end 