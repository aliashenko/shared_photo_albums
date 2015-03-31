class AlbumViewer < ActiveRecord::Base
  belongs_to :viewer, class_name: User, foreign_key: :user_id
  belongs_to :shared_album, class_name: Album, foreign_key: :album_id
end
