require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  let(:user) { create(:user) }
  let(:session) { create(:session, user: user) }

  context '.create' do
    it 'returns :created status' do
      post :create, session: {email: user.email, password: attributes_for(:user)[:password]}
      expect(response).to have_http_status(:created)
    end

    it 'creates a Session' do
      expect do
        post :create, session: {email: user.email, password: attributes_for(:user)[:password]}
      end.to change(Session, :count).by(1)
    end

    it 'returns :unauthorized status' do
      post :create, session: {email: user.email, password: 'invalid_password'}
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context '.destroy' do
    before(:each) do
      allow(controller).to receive(:current_session).and_return(session)
    end

    it 'returns :ok status' do
      delete :destroy
      expect(response).to have_http_status(:ok)
    end

    it 'destroys a Session' do
      expect do
        delete :destroy
      end.to change(Session, :count).by(-1)
    end
  end
end
