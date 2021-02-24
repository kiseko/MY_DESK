class Genre < ApplicationRecord

  belongs_to :item

  validates :item_id, presence: true
  validates :name, presence: true, length: {maximum: 30}

end
