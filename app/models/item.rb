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

  validates :user_id, presence: true
  validates :brand, length: {maximum: 14}
  validates :name, presence: true, length: {maximum: 14}
  validates :comment_status, presence: true

  accepts_nested_attributes_for :item_pictures

  def self.search(search)
    where(["brand LIKE? or items.name LIKE?", "%#{search}%", "%#{search}%"])
  end

end
