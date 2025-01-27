class PieceImage < ApplicationRecord
  belongs_to :piece
  has_many :lines
  has_one_attached :image
end
