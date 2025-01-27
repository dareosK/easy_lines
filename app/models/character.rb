class Character < ApplicationRecord
  belongs_to :piece
  has_many :lines
end
