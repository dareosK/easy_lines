class AddImageReferenceToPieceImages < ActiveRecord::Migration[7.1]
  def change
    add_reference :piece_images, :image, null: false, foreign_key: true
  end
end
