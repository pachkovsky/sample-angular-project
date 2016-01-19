require 'rails_helper'

RSpec.describe Api::ProfilesController, type: :controller do
  let(:session) { create(:session) }

  before(:each) do
    allow(controller).to receive(:current_session).and_return(session)
  end

  context '.show' do
    it 'returns :ok status' do
      get :show
      expect(response).to have_http_status(:ok)
    end
  end

  context '.update' do
    it 'returns :ok status' do
      put :update, profile: {preferred_working_hours_per_day: 6.5}
      expect(response).to have_http_status(:ok)
    end

    it 'returns :unprocessable_entity status' do
      put :update, profile: {preferred_working_hours_per_day: -1}
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'has errors type of hash' do
      put :update, profile: {preferred_working_hours_per_day: -1}
      expect(json_response_body['errors']).to be_instance_of(Hash)
    end
  end
end
