class ChangeAlbumsColumnName < ActiveRecord::Migration
  def change
    rename_column :albums, :user_id, :owner_id
  end
end
