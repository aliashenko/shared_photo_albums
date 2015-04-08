class AlbumsController < ApplicationController
  load_and_authorize_resource
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = Album.all
  end

  def show
    @photos = @album.photos.all
  end

  def new
    @album = Album.new
    @photo = @album.photos.build
  end

  def edit
  end

  def create
    @album = Album.new(album_params)
    @album.owner = current_user

    respond_to do |format|
      if @album.save
        if params[:photos]
          params[:photos]['image'].each do |a|
            @photo = @album.photos.build(:image => a, :album_id => @album.id)
            unless @photo.save
              format.json { render json: @photo.errors, status: :unprocessable_entity }
            end
          end
        end
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update(album_params)
        if params[:photos]
          params[:photos]['image'].each do |a|
            @photo = @album.photos.build(:image => a, :album_id => @album.id)
            unless @photo.save
              format.json { render json: @photo.errors, status: :unprocessable_entity }
            end
          end
        end
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_path, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_viewers
    @viewers = User.where('email LIKE ? OR name LIKE ?', "%#{params[:user_name]}%", "%#{params[:user_name]}%")
    render json: @viewers.to_json(only: [], methods: [:label, :user_name, :value])
  end

  def share
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:name, :description, photos_attributes: [:id, :album_id, :image])
    end
end
