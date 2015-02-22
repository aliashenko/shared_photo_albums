require 'rails_helper'

RSpec.describe AlbumsController, :type => :controller do
  describe 'GET index' do
    before(:each) do
      login_user
      get :index
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders an index template' do
      expect(response).to render_template('index')
    end

    it 'populates an array of albums' do
      album1 = FactoryGirl.create(:album)
      album2 = FactoryGirl.create(:album)
      expect(assigns(:albums)).to eq([album1, album2])
    end
  end

  describe 'GET show' do
    let(:album) { FactoryGirl.create(:album) }

    before(:each) do
      login_user
      get :show, { id: album.id }
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders a show template' do
      expect(response).to render_template('show')
    end

    it 'assigns the album to @album' do
      expect(assigns(:album)).to eq(album)
    end
  end

  describe 'GET new' do
    before(:each) do
      login_user
      get :new
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders a new template' do
      expect(response).to render_template('new')
    end

    it 'assigns the new Album to @album' do
      expect(assigns(:album)).to be_kind_of(Album)
    end
  end

  describe 'POST create' do
    before(:each) { login_user }

    context 'with valid attributes' do
      it 'creates a new album' do
        expect{ post :create, album: FactoryGirl.attributes_for(:album) }.to change(Album, :count).by(1)
      end

      it 'redirects to the new album' do
        post :create, album: FactoryGirl.attributes_for(:album)
        expect(response).to redirect_to Album.last
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new album' do
        expect{ post :create, album: FactoryGirl.attributes_for(:album, name: nil) }.to_not change(Album, :count)
      end

      it 're-renders the new method' do
        post :create, album: FactoryGirl.attributes_for(:album, name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    before(:each) do
      login_user
      @album = FactoryGirl.create(:album, user: @current_user, name: 'Album', description: 'New description')
    end

    context 'valid attributes' do
      it 'located the requested @album' do
        put :update, id: @album, album: FactoryGirl.attributes_for(:album)
        expect(assigns(:album)).to eq(@album)
      end

      it "changes @album's attributes" do
        put :update, id: @album, album: FactoryGirl.attributes_for(:album, name: 'Test album', description: 'Test description')
        @album.reload
        expect(@album.name).to eq('Test album')
        expect(@album.description).to eq('Test description')
      end

      it 'redirects to the updated album' do
        put :update, id: @album, album: FactoryGirl.attributes_for(:album)
        expect(response).to redirect_to @album
      end
    end

    context 'invalid attributes' do
      it 'locates the requested @album' do
        put :update, id: @album, album: FactoryGirl.attributes_for(:album, name: nil)
        expect(assigns(:album)).to eq(@album)
      end
    
      it "does not change @album's attributes" do
        put :update, id: @album, album: FactoryGirl.attributes_for(:album, name: nil, description: 'Test description')
        @album.reload
        expect(@album.name).to eq('Album')
        expect(@album.description).not_to eq('Test description')
      end

      it 're-renders the edit method' do
        put :update, id: @album, album: FactoryGirl.attributes_for(:album, name: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      login_user
      @album = FactoryGirl.create(:album, user: @current_user)
    end
    
    it 'deletes the album' do
      expect{ delete :destroy, id: @album }.to change(Album, :count).by(-1)
    end

    it 'redirects to albums#index' do
      delete :destroy, id: @album
      expect(response).to redirect_to albums_url
    end
  end
end
