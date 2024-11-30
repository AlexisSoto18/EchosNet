class Tweeet < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :retweets, dependent: :destroy
  has_many :retweeters, through: :retweets, source: :user
end
