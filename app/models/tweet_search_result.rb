class TweetSearchResult
  include Mongoid::Document
  include Mongoid::Timestamps

  field :query, type: String
  field :options, type: Hash
  field :tweets, type: Array

  validates :tweets, presence: true

  index({query: 1, options: 1}, unique: true)
end
