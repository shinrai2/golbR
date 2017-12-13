class Comment < ApplicationRecord
  belongs_to :post
  default_scope -> { order(created_at: :desc) }
  validates :post_id, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@(?:[a-z\d\-]+\.)+[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, 
            format: { with: VALID_EMAIL_REGEX }
  validates :content, presence: true
end
