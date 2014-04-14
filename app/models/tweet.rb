class Tweet < ActiveRecord::Base
  def self.get_tweets
    
    @timeline = MY_TWITTER_CLIENT.home_timeline(:count => 200)
    last_id = @timeline.last.id 

    text_array = []

    @timeline.each do |tweet_obj|
      text_array << tweet_obj.text
    end 

    2.times do 
      @timeline = MY_TWITTER_CLIENT.home_timeline(:count => 200, :max_id => last_id)
      # binding.pry
      last_id = @timeline.last.id 

      @timeline.each do |tweet_obj|
        text_array << tweet_obj.text
      end 
    end  

    return text_array
  end 
end 