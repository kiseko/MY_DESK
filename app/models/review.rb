class Review < ApplicationRecord

  belongs_to :item

  validates :item_id, presence: true, uniqueness: true
  validates :rating, presence: true
  validates :description, presence: true, length: {maximum: 255}

end
