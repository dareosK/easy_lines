class CreatePieceImages < ActiveRecord::Migration[7.1]
  def change
    create_table :piece_images do |t|
      t.references :piece, null: false, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
