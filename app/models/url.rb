class Url
  attr_accessor :address, :appearances

  def initialize 
    @tweet_objs = []
    @appearances = 1
  end 

  def tweet_objs 
    @tweet_objs
  end 

  def add_tweet_obj(tweet_obj)
    @tweet_objs << tweet_obj
  end 
end 