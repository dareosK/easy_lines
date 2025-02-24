class Character < ApplicationRecord
  belongs_to :piece
  has_many :lines
  has_many :piece_lines

  # validates :name, presence: true
end
