class TwitterSearchResult
  include Mongoid::Document
  include Mongoid::Timestamps

  field :query, type: String
  field :options, type: Hash
  embeds_many :results, class_name: "ResultTweet"

  validates :results, presence: true

  index({query: 1, options: 1}, unique: true)
end

class ResultTweet
  include Mongoid::Document
  embedded_in :twitter_search_result, inverse_of: :results

  field :created_at, type: DateTime
  field :twitter_id, type: String
  field :_id, type: String, default: ->{ twitter_id }
  attr_protected
end
