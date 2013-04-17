class HomeController < ApplicationController
  def index
    @users = User.all
    client = Twitter::Client.new(
        oauth_token: '14730924-OL77JFECKu31uIXaoJJEYR817MEq3u6GJzGsIa31b',
        oauth_token_secret: 'RyZBlCDDQo4idFO00asAAsBblzcROkRr4czFCBt1kwY'
    )
    @tweets = client.search("to:justinbieber marry me", :count => 3, :result_type => "recent").results
  end
end
