require 'rails_helper'

RSpec.describe Api::EntriesController, type: :controller do
  let(:session) { create(:session) }
  let(:entry) { create(:entry, user: session.user) }
  let(:entry_params) { {date: Date.today, hours: 1.0, note: 'Did some job'} }

  def stub_admin
    allow(controller).to receive(:current_session).and_return(create(:session, user: create(:user, role: 'admin')))
  end

  before(:each) do
    allow(controller).to receive(:current_session).and_return(session)
  end

  context '.index' do
    it 'returns user entries' do
      5.times { create(:entry, user: session.user) }
      get :index
      expect(json_response_body.count).to be == 5
    end

    it 'returns only user entries' do
      create(:entry)
      5.times { create(:entry, user: session.user) }
      get :index
      expect(json_response_body.count).to be == 5
    end

    it 'returns all user entries' do
      5.times { create(:entry) }
      stub_admin
      get :index
      expect(json_response_body.count).to be == 5
    end
  end

  context '.create' do
    it 'returns :created status' do
      post :create, entry: entry_params
      expect(response).to have_http_status(:created)
    end

    it 'creates Entry' do
      expect{ post :create, entry: entry_params }.to change(Entry, :count).by(1)
    end

    it 'returns :unprocessable_entity' do
      post :create
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns errors as a hash' do
      post :create
      expect(json_response_body).to be_instance_of(Hash)
    end

    it 'ignores user_id attribute' do
      post :create, entry: entry_params.merge(user_id: create(:user).id)
      expect(json_response_body['user_id']).to be == session.user_id.to_s
    end

    it 'accepts user_id if current_user is admin' do
      stub_admin
      other_user = create(:user)
      post :create, entry: entry_params.merge(user_id: other_user.id)
      expect(json_response_body['user_id']).to be == other_user.id.to_s
    end
  end

  context '.update' do
    it 'returns :ok status' do
      put :update, id: entry.id, entry: {note: 'fixed note'}
      expect(response).to have_http_status(:ok)
    end

    it 'updates entry' do
      put :update, id: entry.id, entry: {note: 'fixed note'}
      expect(entry.note).to_not be == entry.reload.note
    end

    it 'returns :unprocessable_entity' do
      put :update, id: entry.id, entry: {note: nil}
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns errors as a hash' do
      put :update, id: entry.id, entry: {note: nil}
      expect(json_response_body).to be_instance_of(Hash)
    end

    it 'returns :not_found for non-user entry' do
      put :update, id: create(:entry).id, entry: {note: 'fixed note'}
      expect(response).to have_http_status(:not_found)
    end

    it 'returns :ok if is user is admin' do
      stub_admin
      put :update, id: create(:entry).id, entry: {note: 'fixed note'}
      expect(response).to have_http_status(:ok)
    end
  end

  context '.destroy' do
    it 'returns :ok status' do
      delete :destroy, id: entry.id
      expect(response).to have_http_status(:ok)
    end

    it 'returns :not_found for non-user entry' do
      delete :destroy, id: create(:entry).id
      expect(response).to have_http_status(:not_found)
    end

    it 'returns :ok if is user is admin' do
      stub_admin
      delete :destroy, id: create(:entry).id
      expect(response).to have_http_status(:ok)
    end
  end
end
