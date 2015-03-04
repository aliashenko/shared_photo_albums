class Ability
  include CanCan::Ability

  def initialize(user)
    unless user
      can :read, :all
    else
      can :read, :all
      can :manage, Album, user_id: user.id
      can :manage, Photo do |photo|
        user.albums.include?(photo.album)
      end
      can :new, Photo, user.albums.include?(:album_id)
      can :manage, User, id: user.id
    end
  end
end
