class Piece < ApplicationRecord
  has_many :piece_images
  has_many :characters
  has_many :lines, through: :piece_images
  has_many_attached :images

  # validates :title, presence: true
  # validates :role, presence: true
end
