class CreateAlbumViewers < ActiveRecord::Migration
  def change
    create_table :album_viewers do |t|
      t.belongs_to :user, index: true
      t.belongs_to :album, index: true

      t.timestamps null: false
    end
    add_foreign_key :album_viewers, :users
    add_foreign_key :album_viewers, :albums
  end
end
