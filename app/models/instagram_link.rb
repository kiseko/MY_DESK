class InstagramLink < ApplicationRecord

  belongs_to :user

  VALID_INSTAGRAM_URL_REGEX = /\A(https)\:\/{2}(www.instagram.com)\/[a-z0-9\_.]+\/?\z/i

  validates :user_id, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true, format: { with: VALID_INSTAGRAM_URL_REGEX }
  validates :status, presence: true

end
