class AmazonLink < ApplicationRecord

  belongs_to :item

  validates :item_id, presense: true
  validates :url, presense: true

end
