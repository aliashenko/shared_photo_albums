class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.belongs_to :album, index: true

      t.timestamps null: false
    end
    add_foreign_key :photos, :albums
  end
end
