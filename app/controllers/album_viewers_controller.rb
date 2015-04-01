class AlbumViewersController < ApplicationController
  before_action :find_user

  def index
    @shared_albums = @user.shared_albums
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
