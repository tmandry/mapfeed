class TweetCache
  def search(query, options = {})
    # Check for cached results
    # Some options we do not want to subject our DB query to
    query_options = options.except(:count, :until, :since_id, :max_id)
    criteria = TwitterSearchResult.where(query: query, options: query_options)
    cache = criteria.first_or_initialize

    # Update results by hitting the Twitter API, if needed
    if cache.results.count == 0 or cache.updated_at < 1.minute.ago
      cache.options = query_options  # not sure why I have to do this.. Mongoid bug?

      results = twitter_client.search(query, options).results
      cache.results = results.collect {|result| ResultTweet.new(mongoize(result.to_hash))}

      cache.save
    end

    cache.results.collect { |tweet| Twitter::Tweet.new(demongoize(tweet.attributes)) }
  end

  def twitter_client
    @@twitter_client ||= Twitter::Client.new(
        oauth_token: '14730924-OL77JFECKu31uIXaoJJEYR817MEq3u6GJzGsIa31b',
        oauth_token_secret: 'RyZBlCDDQo4idFO00asAAsBblzcROkRr4czFCBt1kwY'
    )
  end

  def mongoize(hash)
    # Mongo stores the id field as _id
    hash[:twitter_id] = hash[:id]
    hash.delete(:id)
    # Metadata isn't needed and messes with Mongo
    hash.delete(:metadata)

    hash
  end
  def demongoize(hash)
    # Convert back to make the Twitter gem happy
    hash = hash.with_indifferent_access
    hash[:id] = hash[:twitter_id]
    hash.delete(:twitter_id)
    hash
  end
end
