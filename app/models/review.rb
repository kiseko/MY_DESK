class Review < ApplicationRecord

  belongs_to :item

  validates :item_id, presence: true
  validates :rating, presence: true
  validates :description, presence: true

end
