class CreatePieces < ActiveRecord::Migration[7.1]
  def change
    create_table :pieces do |t|
      t.string :title
      t.string :role

      t.timestamps
    end
  end
end
