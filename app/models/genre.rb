class Genre < ApplicationRecord

  belongs_to :item

  validates :item_id, presence: true
  validates :name, presence: true

end
