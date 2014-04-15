class TweetsController < ApplicationController
  def show
    
    @twitter_username = request.env["omniauth.auth"]["info"]["nickname"] # params[:twitter_username]
    @user_name = request.env["omniauth.auth"]["info"]["name"]
    @twitter_avatar_url = request.env["omniauth.auth"]["info"]["image"]
    
    # @url_array = Tweet.get_tweets 
    # @tweet_id_url_array_hash = Tweet.make_tweet_id_url_array_hash
    # @url_count_hash = Tweet.make_url_count_hash

    @url_obj_array = Tweet.make_url_objs
  end 

  # def index
  # @searches = Project.published.financed     
  # @project_pages = form_search(params)
  # end
end
