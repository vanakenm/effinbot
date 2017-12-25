client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV('TWITTER_CONSUMER_KEY')
  config.consumer_secret     = ENV('TWITTER_CONSUMER_SECRET')
  config.access_token        = ENV('TWITTER_ACCESS_TOKEN')
  config.access_token_secret = ENV('TWITTER_ACCESS_TOKEN_SECRET')
end

tweets = client.get_all_tweets('effinbirds')

# Let's find the tweets that contains an image
raw = tweets.map do |t|
  next unless t.media && t.media.first && t.media.first.uri
  image_url = t.media.first.media_uri
  tweet_url = t.uri

  [image_url, tweet_url]
end.compact

raw.each do |r|
  next if EffinQuote.find_by(url: r.first.to_s)

  EffinQuote.create(url: r.first.to_s, twitter_url: r.second.to_s)
end

# From Twitter gem example of getting all tweets for a given account
def collect_with_max_id(collection = [], max_id = nil, &block)
  response = yield(max_id)
  collection += response
  response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
end

def client.get_all_tweets(user)
  collect_with_max_id do |max_id|
    options = { count: 200, include_rts: true }
    options[:max_id] = max_id unless max_id.nil?
    user_timeline(user, options)
  end
end
