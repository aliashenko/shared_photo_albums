class ShareAlbumController < ApplicationController
  before_action :album, only: [:show, :create]

  def show
    @viewers = @album.viewers

    respond_to do |format|
      format.js
    end
  end

  def create
    @viewers_ids = params[:share_album][:album_viewers].split(" ").map { |s| s.to_i }.uniq
    @viewers_ids.delete('')
    @viewers = User.where(id: @viewers_ids)
    @album.viewers = @viewers
    @email = params[:share_album][:email]

    unless @email.empty?
      ShareAlbumMailer.welcome_email(@email, @album).deliver_now
    end

    redirect_to @album
  end

  def viewers
    @viewers = User.where('email LIKE ? OR name LIKE ?', "%#{params[:user_name]}%", "%#{params[:user_name]}%")
    render json: @viewers.to_json(only: [], methods: [:label, :user_name, :value])
  end

  private

  def album
    @album = Album.find(params[:id])
  end
end
