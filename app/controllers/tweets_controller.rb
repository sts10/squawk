class TweetsController < ApplicationController
  def show
    # binding.pry
    @twitter_username = request.env["omniauth.auth"]["info"]["nickname"] # params[:twitter_username]
    @user_name = request.env["omniauth.auth"]["info"]["name"]
    @twitter_avatar_url = request.env["omniauth.auth"]["info"]["image"]
    
    @text_array = Tweet.get_tweets 
  end 

  # def index
  # @searches = Project.published.financed     
  # @project_pages = form_search(params)
  # end
end
