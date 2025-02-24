class Image < ApplicationRecord
  has_many :piece_images, dependent: :destroy
  has_many :pieces, through: :piece_images

  has_one_attached :file

  # validates :filename, presence: true
end
