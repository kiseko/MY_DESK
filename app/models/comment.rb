class Comment < ApplicationRecord

  has_many :replies, dependent: :destroy
  belongs_to :user
  belongs_to :item

  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :description, presence: true

end
