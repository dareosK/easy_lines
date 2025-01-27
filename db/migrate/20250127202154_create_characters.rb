class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.references :piece, null: false, foreign_key: true
      t.string :name
      t.string :voice

      t.timestamps
    end
  end
end
