class Album < ActiveRecord::Base
  belongs_to :owner, class_name: User, foreign_key: "owner_id"
  has_many :photos, dependent: :destroy
  has_many :album_viewers
  has_many :viewers, class_name: User, through: :album_viewers, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :owner_id

  scope :shared_with_user, lambda { |owner|
    where(owner: owner).includes(:viewers)
  }
end
