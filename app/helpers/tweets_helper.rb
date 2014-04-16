module TweetsHelper
  include Twitter::Autolink

  # <blockquote class="twitter-tweet" lang="en">
  # <p>Seriously. MT <a href="https://twitter.com/loganhasson">@loganhasson</a>: .<a href="https://twitter.com/dhh">@dhh</a> What’s the best way to use secrets.yml in 4.1? I am finding that it’s not all that useful</p>&mdash; Sam Schlinkert (@sts10) <a href="https://twitter.com/sts10/statuses/454271054589202433">April 10, 2014</a></blockquote>

  def linkify_tweet(tweet_obj)
    html = auto_link(tweet_obj.text)
  end 

  def pretty_tweet(tweet_obj)
    html = "<blockquote class=\"twitter-tweet\" lang=\"en\"><p>"
    html = html + linkify_tweet(tweet_obj)
    html = html + "</p>&mdash; #{tweet_obj.user_name} (@#{tweet_obj.user_handle}) <a href=\"#{tweet_obj.tweet_url}\">#{tweet_obj.created_at.strftime("%m/%d/%y")}</a></blockquote>"
    return html.html_safe
  end 
  
end
