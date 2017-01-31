class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  validates :name, presence: true, length: {maximum: 255}, uniqueness: true
end
