class AlbumViewersController < ApplicationController
  before_action :find_album, only: :show

  def show
    @viewers = @album.viewers

    respond_to do |format|
      format.js
    end
  end

  private

  def find_album
    @album = Album.find(params[:album_id])
  end
end
