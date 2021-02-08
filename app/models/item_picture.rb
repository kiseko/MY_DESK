class ItemPicture < ApplicationRecord

  belongs_to :item

  validates_presence_of :item
  validates :image, presence: true

  attachment :image

end
