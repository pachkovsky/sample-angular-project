require 'rails_helper'

RSpec.describe Entry, type: :model do
  it 'has a factory' do
    expect{ create(:entry) }.to change(Entry, :count).by(1)
  end
end
