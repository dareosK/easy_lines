class PieceImage < ApplicationRecord
  belongs_to :piece
  belongs_to :image
  has_many :lines, dependent: :destroy

  # validates :order, presence: true
end
