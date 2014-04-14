class Tweet < ActiveRecord::Base
  def self.get_tweets(this_user)
    @timeline = MY_TWITTER_CLIENT.user_timeline(this_user)
    text_array = []
    @timeline.each do |tweet_obj|
      text_array << tweet_obj.text
    end 

    return text_array
  end 
end 