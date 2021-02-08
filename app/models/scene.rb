class Scene < ApplicationRecord

  has_many :scene_items, dependent: :destroy
  belongs_to :user

  validates :user_id, presence: true
  validates :image, presence: true

  attachment :image

end
