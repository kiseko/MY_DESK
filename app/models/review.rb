class Review < ApplicationRecord

  belongs_to :item

  validates :item_id, presence: true, uniqueness: true
  validates :rating, presence: true, format: { with: /[1-5]/ }
  validates :description, presence: true, length: {maximum: 255}

end
