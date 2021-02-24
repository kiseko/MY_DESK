class HomepageLink < ApplicationRecord

  belongs_to :item

  validates :item_id, presence: true, uniqueness: true
  validates :url, presence: true

end
