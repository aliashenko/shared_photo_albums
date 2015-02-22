class AddDescriptionColumnToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :description, :string
  end
end
