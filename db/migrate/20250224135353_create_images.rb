class CreateImages < ActiveRecord::Migration[7.1]
  def change
    create_table :images do |t|
      t.string :filename
      t.string :content_type
      t.integer :byte_size
      t.string :checksum

      t.timestamps
    end
  end
end
