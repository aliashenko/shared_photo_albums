require 'rails_helper'

RSpec.describe AlbumViewersController, :type => :controller do
  describe 'GET index' do
    before(:each) do
      login_user
    end

    it 'has a 200 status code' do
      get :index, user_id: @current_user.id
      expect(response.status).to eq(200)
    end

    it 'renders an index template' do
      get :index, user_id: @current_user.id
      expect(response).to render_template('index')
    end

    it 'populates an array of albums' do
      album1 = FactoryGirl.create(:album)
      album2 = FactoryGirl.create(:album)
      @current_user.shared_albums << [album1, album2]
      get :index, user_id: @current_user.id
      expect(assigns(:shared_albums)).to include(album1, album2)
    end
  end
end
