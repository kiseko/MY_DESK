class SceneItem < ApplicationRecord

  belongs_to :scene
  belongs_to :item

  validates :scene_id, presence: true
  validates :item_id, presence: true

end
