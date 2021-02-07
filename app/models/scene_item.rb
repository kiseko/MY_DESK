class SceneItem < ApplicationRecord

  belongs_to :scene
  belongs_to :item

  validates :scene_id, presense: true
  validates :item_id, presense: true

end
