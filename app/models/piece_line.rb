class PieceLine < ApplicationRecord
  belongs_to :piece
  belongs_to :character
  belongs_to :line

  # validates :order, presence: true
end
