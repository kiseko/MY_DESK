class Review < ApplicationRecord

  belongs_to :item

  validates :item_id, presense: true
  validates :rating, presense: true
  validates :description, presense: true

end
