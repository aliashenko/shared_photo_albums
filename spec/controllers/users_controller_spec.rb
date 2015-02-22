require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
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
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      expect(assigns(:users)).to include(user1, user2)
    end
  end

  describe 'GET show' do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      login_user
      get :show, { id: user.id }
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders a show template' do
      expect(response).to render_template('show')
    end

    it 'assigns the user to @user' do
      expect(assigns(:user)).to eq(user)
    end
  end
end
