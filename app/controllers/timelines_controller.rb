class TimelinesController < ApplicationController
  def show
    @twitter_username = request.env["omniauth.auth"]["info"]["nickname"]
    @user_name = request.env["omniauth.auth"]["info"]["name"]
    @twitter_avatar_url = request.env["omniauth.auth"]["info"]["image"]
    
    @oauth_token = request.env["omniauth.auth"]["extra"]["access_token"].params[:oauth_token]
    @oauth_token_secret = request.env["omniauth.auth"]["extra"]["access_token"].params[:oauth_token_secret]

    @timeline = Timeline.new(@oauth_token, @oauth_token_secret)

    @url_objs = @timeline.make_url_objs
    @max_appearances = @timeline.get_max_appearances(@url_objs)
  end 
end
