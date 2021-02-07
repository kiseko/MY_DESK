class ItemPicture < ApplicationRecord

  belongs_to :item

  validates :item_id, presense: true
  validates :image, presense: true

  attachment :image

end
