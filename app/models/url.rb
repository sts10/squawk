class Url
  attr_accessor :address, :appearances

  def initialize 
    @tweet_objs = []
  end 

  def tweet_objs 
    @tweet_objs
  end 

  def add_tweet_obj(tweet_obj)
    @tweet_objs << tweet_obj
  end 

  def well_formed?
    # binding.pry
    self.address[-1] != '.' && self.address[-2] != '.'
  end 
  
end 