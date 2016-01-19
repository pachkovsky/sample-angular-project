require 'rails_helper'

RSpec.describe Session, type: :model do
  it 'has a factory' do
    expect{ create(:session) }.to change(Session, :count).by(1)
  end
end
