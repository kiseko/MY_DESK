class SceneItem < ApplicationRecord

  belongs_to :scene
  belongs_to :item

  validates :scene_id, presence: true
  validates :item_id, presence: true

  def self.search(search_item, search_genre_item)
    where(item_id: search_item.ids).or(where(item_id: search_genre_item.ids))
  end

end
