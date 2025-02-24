class CreatePieceLines < ActiveRecord::Migration[7.1]
  def change
    create_table :piece_lines do |t|
      t.references :piece, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true
      t.references :line, null: false, foreign_key: true
      t.integer :order

      t.timestamps
    end

    add_index :piece_lines, [:piece_id, :order]
  end
end
