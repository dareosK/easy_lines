class Piece < ApplicationRecord
  has_many :piece_images
  has_many :piece_lines
  has_many :images, through: :piece_images
  has_many :characters
  has_many :lines, through: :piece_lines

  belongs_to :user

  # validates :title, presence: true
  # validates :role, presence: true

  def ordered_lines
    piece_lines.order(:order).map(&:line)
  end
end
