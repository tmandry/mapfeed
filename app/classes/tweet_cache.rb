class TweetCache
  def search(query, options = {})
    client.search(query, options).results
  end

  def client
    @@client ||= Twitter::Client.new(
        oauth_token: '14730924-OL77JFECKu31uIXaoJJEYR817MEq3u6GJzGsIa31b',
        oauth_token_secret: 'RyZBlCDDQo4idFO00asAAsBblzcROkRr4czFCBt1kwY'
    )
  end
end
