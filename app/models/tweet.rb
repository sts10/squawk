class Tweet 
  attr_reader :tweet_id, :text, :user_name, :user_handle,
              :tweet_url, :created_at, :expanded_urls

  def initialize(tweet_obj)
    @tweet_id = tweet_obj.id
    @text = tweet_obj.text
    @user_name = tweet_obj.user.name
    @user_handle = tweet_obj.user.handle
    @tweet_url = tweet_obj.url
    @created_at = tweet_obj.created_at
    @expanded_urls = tweet_obj.urls.map { |url| url.attrs[:expanded_url] }    
  end

end
  


