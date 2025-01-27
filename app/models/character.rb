class Character < ApplicationRecord
  belongs_to :piece
  has_many :lines

  # validates :name, presence: true
end
