class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :albums, class_name: Album, foreign_key: "owner_id", dependent: :destroy
  has_many :album_viewers
  has_many :shared_albums, class_name: Album, through: :album_viewers

  mount_uploader :avatar, AvatarUploader

  validates :email, presence: true, format: {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :if => :email?},
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid,
          remote_avatar_url: data["image"]<<'0',
          password: Devise.friendly_token[0,20],
        )
      end
    end
  end

  def value
    id
  end

  def label
    "#{name} #{email}"
  end

  def user_name
    name || email
  end
end
