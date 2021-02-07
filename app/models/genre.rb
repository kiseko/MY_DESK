class Genre < ApplicationRecord

  belongs_to :item

  validates :item_id, presense: true
  validates :name, presense: true

end
