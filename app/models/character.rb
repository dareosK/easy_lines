class Character < ApplicationRecord
  belongs_to :piece
  has_many :lines, dependent: :destroy
  has_many :piece_lines, dependent: :destroy

  # validates :name, presence: true
end
