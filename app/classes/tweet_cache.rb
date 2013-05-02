class TweetCache
  def search(query, options = {})
    # Check for cached results
    # Some options we do not want to subject our DB query to
    query_options = options.except(:count, :until, :since_id, :max_id)
    criteria = TweetSearchResult.where(query: query, options: query_options)
    cache = criteria.first_or_initialize

    # Update results by hitting the Twitter API, if needed
    if not cache.tweets or cache.updated_at < 1.minute.ago
      cache.options = query_options  # not sure why I have to do this.. Mongoid bug?
      cache.tweets = client.search(query, options).results.collect {|tweet| tweet.to_hash}
      cache.save
    end

    cache.tweets.collect {|hash| Twitter::Tweet.new(hash.with_indifferent_access)}
  end

  def client
    @@client ||= Twitter::Client.new(
        oauth_token: '14730924-OL77JFECKu31uIXaoJJEYR817MEq3u6GJzGsIa31b',
        oauth_token_secret: 'RyZBlCDDQo4idFO00asAAsBblzcROkRr4czFCBt1kwY'
    )
  end
end
