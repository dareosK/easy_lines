class Line < ApplicationRecord
  belongs_to :character
  belongs_to :piece_image
  #  validates :text, presence: true
  #  validates :order, presence: true
end
