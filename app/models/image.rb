class Image < ApplicationRecord
  has_many :piece_images
  has_many :pieces, through: :piece_images
  
  has_one_attached :file

  # validates :filename, presence: true
end
