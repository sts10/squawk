class Tweet # < ActiveRecord::Base
  attr_reader :tweet_id
  attr_reader :text
  attr_reader :user_name
  attr_reader :user_handle
  attr_reader :tweet_url
  attr_reader :created_at

  def initialize(tweet_obj)
    @tweet_id = tweet_obj.id
    @text = tweet_obj.text
    @user_name = tweet_obj.user.name
    @user_handle = tweet_obj.user.handle
    @tweet_url = tweet_obj.url
    @created_at = tweet_obj.created_at

    @url_array = self.extract_urls
  end

  def extract_urls
    https = /https?:\/\/[\S]+/
    links = self.text.scan(https) 
    links.reject!{|link| link.include?("\u2026")}
    # self.url_array = links
    return links
  end 

  def url_array 
    @url_array
  end 

  # def add_url(url)
  #   @url_array << url
  # end  

  
end
  


