class Reply < ApplicationRecord

  belongs_to :user
  belongs_to :comment

  validates :user_id, presense: true
  validates :comment_id, presense: true
  validates :description, presense: true

end
