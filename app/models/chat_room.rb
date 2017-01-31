class ChatRoom < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: {maximum: 255}, uniqueness: true
end
