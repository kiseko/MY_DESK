class Scene < ApplicationRecord

  has_many :scene_items, dependent: :destroy
  belongs_to :user

  validates :user_id, presense: true
  validates :image, presense: true

  attachment :image

end
