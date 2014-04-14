class TweetsController < ApplicationController
  def show
    # binding.pry
    @twitter_username = request.env["omniauth.auth"]["info"]["nickname"] # params[:twitter_username]
    @user_name = request.env["omniauth.auth"]["info"]["name"]
    @twitter_avatar_url = request.env["omniauth.auth"]["info"]["image"]
    
    @url_array = Tweet.get_tweets 
    @tweet_hash = Tweet.make_hash
    @final = Tweet.make_final_hash
  end 

  # def index
  # @searches = Project.published.financed     
  # @project_pages = form_search(params)
  # end
end
