class Item < ApplicationRecord

  has_many :clips, dependent: :destroy
  has_many :scene_items, dependent: :destroy
  has_many :item_pictures, dependent: :destroy
  has_many :genres, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :review, dependent: :destroy
  has_one :homepage_link, dependent: :destroy
  has_one :amazon_link, dependent: :destroy
  belongs_to :user

  validates :user_id, presense: true
  validates :name, presense: true
  validates :comment_status, presense: true

end
