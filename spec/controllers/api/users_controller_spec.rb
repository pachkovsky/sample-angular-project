require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  let(:regular_user) { create(:user) }
  let(:manager) { create(:user, role: 'manager', managed_users: [regular_user]) }
  let(:admin) { create(:user, role: 'admin') }

  context '.index' do
    it 'returns :forbidden for regular user' do
      stub_current_user(regular_user)
      get :index, format: :json
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns :ok for manager' do
      stub_current_user(manager)
      get :index, format: :json
      expect(response).to have_http_status(:ok)
    end

    it 'returns :ok for admin' do
      stub_current_user(admin)
      get :index, format: :json
      expect(response).to have_http_status(:ok)
    end

    it 'returns managed users for manager' do
      stub_current_user(manager)
      create(:user)
      manager.update_attribute(:managed_users, [5.times.map{ create(:user) }])
      get :index, format: :json
      expect(json_response_body.count).to be == manager.managed_users.count
    end

    it 'returns all users for admin' do
      stub_current_user(admin)
      create(:user)
      manager.update_attribute(:managed_users, [5.times.map{ create(:user) }])
      get :index, format: :json
      expect(json_response_body.count).to be == User.count
    end
  end

  context '.show' do
    it 'returns :forbidden for regular user' do
      stub_current_user(regular_user)
      get :show, id: regular_user.id, format: :json
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns :ok for manager' do
      stub_current_user(manager)
      get :show, id: regular_user.id, format: :json
      expect(response).to have_http_status(:ok)
    end

    it 'returns :not_found for manager without access' do
      stub_current_user(manager)
      get :show, id: create(:user).id, format: :json
      expect(response).to have_http_status(:not_found)
    end

    it 'returns :ok for admin' do
      stub_current_user(admin)
      get :show, id: regular_user.id, format: :json
      expect(response).to have_http_status(:ok)
    end
  end

  context '.create' do
    it 'returns :forbidden for regular user' do
      stub_current_user(regular_user)
      post :create, user: attributes_for(:user), format: :json
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns :created for manager' do
      stub_current_user(manager)
      post :create, user: attributes_for(:user), format: :json
      expect(response).to have_http_status(:created)
    end

    it 'returns :created for admin' do
      stub_current_user(admin)
      post :create, user: attributes_for(:user), format: :json
      expect(response).to have_http_status(:created)
    end
  end

  context '.update' do
    it 'returns :forbidden for regular user' do
      stub_current_user(regular_user)
      put :update, id: regular_user.id, user: {email: 'new@example.com'}, format: :json
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns :ok for manager' do
      stub_current_user(manager)
      put :update, id: regular_user.id, user: {email: 'new@example.com'}, format: :json
      expect(response).to have_http_status(:ok)
    end

    it 'returns :ok for admin' do
      stub_current_user(admin)
      put :update, id: regular_user.id, user: {email: 'new@example.com'}, format: :json
      expect(response).to have_http_status(:ok)
    end
  end

  context '.destroy' do
    it 'returns :forbidden for regular user' do
      stub_current_user(regular_user)
      delete :destroy, id: regular_user.id, format: :json
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns :ok for manager' do
      stub_current_user(manager)
      delete :destroy, id: regular_user.id, format: :json
      expect(response).to have_http_status(:ok)
    end

    it 'returns :not_found for manager without access' do
      stub_current_user(manager)
      delete :destroy, id: create(:user).id, format: :json
      expect(response).to have_http_status(:not_found)
    end

    it 'returns :ok for admin' do
      stub_current_user(admin)
      delete :destroy, id: regular_user.id, format: :json
      expect(response).to have_http_status(:ok)
    end
  end
end
