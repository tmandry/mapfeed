class HomeController < ApplicationController
  def index
    @users = User.all
    client = Twitter::Client.new(
        oauth_token: '14730924-OL77JFECKu31uIXaoJJEYR817MEq3u6GJzGsIa31b',
        oauth_token_secret: 'RyZBlCDDQo4idFO00asAAsBblzcROkRr4czFCBt1kwY'
    )
    # latitude = 30.6278
    # longitude = -96.3342
    # cStat = latitude.to_s + ',' + longitude.to_s + ',2mi'

	@tweets = client.search("-rt -http -@", :geocode => "30.6278,-96.3342,2mi", :count => 8, :result_type => "recent").results
    # @tweets = client.search("bachata",:count => 8, :result_type => "recent").results
  end
end
