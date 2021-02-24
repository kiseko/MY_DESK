class AmazonLink < ApplicationRecord

  belongs_to :item

  VALID_AMAZON_URL_REGEX = /\A(https)\:\/{2}(www.amazon.co.jp)\/.+\z/i

  validates :item_id, presence: true, uniqueness: true
  validates :url, presence: true, format: { with:  VALID_AMAZON_URL_REGEX }

end
