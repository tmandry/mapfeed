class HomeController < ApplicationController
  def index
    @users = User.all
    @query = params[:query] rescue " "

    # latitude = 30.6278
    # longitude = -96.3342
    # cStat = latitude.to_s + ',' + longitude.to_s + ',2mi'

	@tweets = TweetCache.new.search(@query, :geocode => "30.6278,-96.3342,2mi", :count => 10, :result_type => "recent")
    # @tweets = client.search("bachata",:count => 8, :result_type => "recent").results
  end

  def tweets
    @tweets = TweetCache.new.search(@query, :geocode => "30.6278,-96.3342,2mi", :count => 10, :result_type => "recent")
    render json: @tweets
  end
end
