url_obj_array = []

each tweet
  each url in this tweet
    if url_obj_array != [] && find url in url_obj_array
      appearance + 1 
      add this tweet to this url_obj

    elsif url is well_formed
      create new url_obj
      add url_obj to url_obj_array
    end

  end
end


url_obj_array.detect {|url_obj| url_obj.address == url }




url_obj = url_obj_array.detect {|url_obj| url_obj.address == url } # if well_formed?(url)

if url_obj 





# if tweet is a retweet
#   get parent tweet
#   set this tweet's url_obj.url = the url in the parent tweet
# end  

# if url_obj.tweet_objs.first.retweet?
#   parent_tweet = url_obj.tweet_objs.first.retweeted_tweet
# end