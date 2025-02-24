class Line < ApplicationRecord
  belongs_to :character
  belongs_to :piece_image
  has_many :piece_lines, dependent: :destroy
  #  validates :text, presence: true
  #  validates :order, presence: true
end
