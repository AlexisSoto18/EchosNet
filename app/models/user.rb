class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweeets
  has_many :retweets
  has_many :retweeted_tweeets, through: :retweets, source: :tweeet
  # Relación de seguidores
  has_many :follower_relationships, foreign_key: :followed_id, class_name: "Following"
  has_many :followers, through: :follower_relationships, source: :follower

  # Relación de seguidos
  has_many :following_relationships, foreign_key: :follower_id, class_name: "Following"
  has_many :followed_users, through: :following_relationships, source: :followed
  def retweeted?(tweeet)
    self.retweets.exists?(tweeet_id: tweeet.id)
  end
end
