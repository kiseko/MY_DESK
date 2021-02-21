class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :followings, dependent: :destroy
  has_many :clips, dependent: :destroy
  has_many :scenes, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_one :instagram_link, dependent: :destroy
  has_one :twitter_link, dependent: :destroy

  validates :unique_name, presence: true, uniqueness: true
  validates :hundle_name, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :status, presence: true

  attachment :image

  def to_param
    unique_name
  end

  def self.search(search)
    User.where(["unique_name LIKE? or hundle_name LIKE? or introduction LIke ?", "%#{search}%", "%#{search}%", "%#{search}%"])
  end

end
