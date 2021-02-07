class Comment < ApplicationRecord

  has_many :replies, dependent: :destroy
  belongs_to :user
  belongs_to :item

  validates :user_id, presense: true
  validates :item_id, presense: true
  validates :description, presense: true

end
