class Photo < ActiveRecord::Base
  belongs_to :album
  mount_uploader :image, ImageUploader

  validates_presence_of :image

  def previous_in_album
    return nil unless self.album
    self.album.photos.where('id < ? and album_id = ?', id, self.album.id).last
  end

  def next_in_album
    return nil unless self.album
    self.album.photos.where('id > ? and album_id = ?', id, self.album_id).first
  end
end
