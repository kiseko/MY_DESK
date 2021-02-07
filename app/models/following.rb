class Following < ApplicationRecord

  belongs_to :user

  validates :user_id, presence: true
  validates :following_user_id, presence: true
  validates :status, presence: true

end
