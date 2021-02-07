class Clip < ApplicationRecord

  belongs_to :user
  belongs_to :item

  validates :user_id, presense: true
  validates :item_id, presense: true

end
