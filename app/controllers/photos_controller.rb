class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def index
    @photos = Photo.all
  end

  def show
  end

  def new
    @photo = Photo.new(album_id: params[:album_id])
  end

  def edit
  end

  def create
    @photo = Photo.new(photo_params, album_id: params[:album_id])

    respond_to do |format|
      if @photo.save
        format.html { redirect_to album_path(id: @photo.album.id), notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: album_path(id: @photo.album.id) }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to album_path(id: @photo.album.id), notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: album_path(id: @photo.album.id) }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to album_path(id: @photo.album.id), notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image, :album_id)
    end
end
