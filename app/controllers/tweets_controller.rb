class TweetsController < ApplicationController
  def show
    
    @twitter_username = request.env["omniauth.auth"]["info"]["nickname"] # params[:twitter_username]
    @user_name = request.env["omniauth.auth"]["info"]["name"]
    @twitter_avatar_url = request.env["omniauth.auth"]["info"]["image"]
    # binding.pry
    
    @oauth_token = request.env["omniauth.auth"]["extra"]["access_token"].params[:oauth_token]
    @oauth_token_secret = request.env["omniauth.auth"]["extra"]["access_token"].params[:oauth_token_secret]


    @url_obj_array = Tweet.make_url_objs(Tweet.make_twitter_client(@oauth_token, @oauth_token_secret))
  end 

  # def index
  # @searches = Project.published.financed     
  # @project_pages = form_search(params)
  # end
end
