class Album < ActiveRecord::Base
  belongs_to :owner, class_name: User, foreign_key: "owner_id"
  has_many :photos, dependent: :destroy
  has_many :album_viewers, dependent: :destroy

  validates_presence_of :name
end
