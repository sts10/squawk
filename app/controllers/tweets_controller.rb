class TweetsController < ApplicationController
  def show
    @twitter_username = params[:twitter_username]
    @text_array = Tweet.get_tweets # (@twitter_username)
  end 

  # def index
  # @searches = Project.published.financed     
  # @project_pages = form_search(params)
  # end
end
