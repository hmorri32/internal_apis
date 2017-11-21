require 'rails_helper'

describe 'Items API' do
  it 'sends a list of yung items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_success
  end
end