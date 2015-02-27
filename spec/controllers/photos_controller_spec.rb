require 'rails_helper'

RSpec.describe PhotosController, :type => :controller do
  let!(:album) { FactoryGirl.create(:album) }
  let!(:photo) { FactoryGirl.create(:photo, album: album) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:photo, album_id: album.id) }
  let(:invalid_attributes) { { album_id: album.id } }

  before(:each) do
    login_user
    @current_user.albums << album
  end

  describe 'GET index' do
    before(:each) { get :index, { album_id: album.id } }

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders an index template' do
      expect(response).to render_template('index')
    end

    it 'populates an array of photos' do
      another_photo = FactoryGirl.create(:photo, album: album)
      expect(assigns(:photos)).to eq([photo, another_photo])
    end
  end

  describe 'GET show' do
    before(:each) { get :show, { album_id: album.id, id: photo.id } }

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders a show template' do
      expect(response).to render_template('show')
    end

    it 'assigns the photo to @photo' do
      expect(assigns(:photo)).to eq(photo)
    end
  end

  describe 'GET new' do
    before(:each) { get :new, { album_id: album.id } }

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders a new template' do
      expect(response).to render_template('new')
    end

    it 'assigns the new Photo to @photo' do
      expect(assigns(:photo)).to be_kind_of(Photo)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested photo as @photo' do
      get :edit, { album_id: album.id, id: photo.id }
      expect(assigns(:photo)).to eq(photo)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Photo' do
        expect {
          post :create, { album_id: album.id, photo: valid_attributes }
        }.to change(Photo, :count).by(1)
      end

      it 'assigns a newly created photo as @photo' do
        post :create, { album_id: album.id, photo: valid_attributes }
        expect(assigns(:photo)).to be_a(Photo)
        expect(assigns(:photo)).to be_persisted
      end

      it 'redirects to the created photo' do
        post :create, { album_id: album.id, photo: valid_attributes }
        expect(response).to redirect_to(album)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved photo as @photo' do
        post :create, { album_id: album.id, photo: invalid_attributes }
        expect(assigns(:photo)).to be_a_new(Photo)
      end

      it 're-renders the new template' do
        post :create, { album_id: album.id, photo: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) { FactoryGirl.attributes_for(:another_photo, album_id: album.id) }

      it 'assigns the requested photo as @photo' do
        put :update, { album_id: album.id, id: photo.to_param, photo: valid_attributes }
        expect(assigns(:photo)).to eq(photo)
      end

      it 'redirects to the photo' do
        put :update, { album_id: album.id, id: photo.to_param, photo: valid_attributes }
        expect(response).to redirect_to(album)
      end
    end

    describe 'with invalid params' do
      let(:invalid_attributes) do
        { image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/wrong_format.pdf'))) }
      end

      it 're-renders the edit template' do
        put :update, { album_id: album.id, id: photo.id, photo: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested photo' do
      expect {
        delete :destroy, { album_id: album.id, id: photo.to_param }
      }.to change(Photo, :count).by(-1)
    end

    it 'redirects to the photos list' do
      delete :destroy, { album_id: album.id, id: photo.to_param }
      expect(response).to redirect_to(album)
    end
  end
end
