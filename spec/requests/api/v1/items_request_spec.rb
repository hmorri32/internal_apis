require 'rails_helper'

describe 'Items API' do
  it 'sends a list of yung items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_success
    expect(JSON.parse(response.body).count).to eq(3)
  end

  it 'can get items by id' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(id)
  end

  it 'can create a new item' do
    item_params = { name: 'Burritos', description: 'sa good' }

    post "/api/v1/items", params: { item: item_params }

    assert_response :success
    expect(response).to be_success
    expect(Item.last.name).to eq(item_params[:name])
  end

  it 'can update existing item' do
    id            = create(:item).id
    previous_name = Item.last.name
    item_params   = { name: 'cool stuff' }

    put "/api/v1/items/#{id}", params: { item: item_params }
    item = Item.find_by(id: id)

    expect(response).to be_success
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq('cool stuff')
  end

  it 'can delete an item' do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"
    expect(response).to be_success
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end