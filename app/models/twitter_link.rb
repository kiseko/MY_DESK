class TwitterLink < ApplicationRecord

  belongs_to :user

  VALID_TWITTER_URL_REGEX = /\A(https)\:\/{2}(twitter.com)\/[a-z0-9+\_]+\/?\z/i

  validates :user_id, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true, format: { with: VALID_TWITTER_URL_REGEX }
  validates :status, presence: true

end
