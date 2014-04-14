class TweetsController < ApplicationController
  def show
    @twitter_username = params[:twitter_username]
    @text_array = get_tweets(@twitter_username)
  end 
end
