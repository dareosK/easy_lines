class CreateLines < ActiveRecord::Migration[7.1]
  def change
    create_table :lines do |t|
      t.references :character, null: false, foreign_key: true
      t.references :piece_image, null: false, foreign_key: true
      t.text :text
      t.integer :order

      t.timestamps
    end
  end
end
