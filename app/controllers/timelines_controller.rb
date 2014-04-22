class TimelinesController < ApplicationController
  def show
    
    @twitter_username = request.env["omniauth.auth"]["info"]["nickname"] # params[:twitter_username]
    @user_name = request.env["omniauth.auth"]["info"]["name"]
    @twitter_avatar_url = request.env["omniauth.auth"]["info"]["image"]
    
    @timeline = Timeline.new
    
    @oauth_token = request.env["omniauth.auth"]["extra"]["access_token"].params[:oauth_token]
    @oauth_token_secret = request.env["omniauth.auth"]["extra"]["access_token"].params[:oauth_token_secret]

    @url_obj_array = @timeline.make_url_objs(@timeline.make_twitter_client(@oauth_token, @oauth_token_secret))
    @max_appearances = @timeline.get_max_appearances(@url_obj_array)
  end 
end
