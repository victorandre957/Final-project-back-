require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  describe "/GET #index" do
    before do
      create(:product)
      create(:product)
      get '/api/v1/products/'
    end

    it { expect(response).to have_http_status(:ok) }

    it 'returns with json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns 2 elements' do
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "/GET #show" do
    let(:product) do
      create(:product)
    end
    context 'showing an existing product' do
      before do
        get "/api/v1/products/show/#{product.id}"
      end

      it { expect(response).to have_http_status(:found) }

      it 'returns with json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns with the correct product' do
        expect(JSON.parse(response.body)["id"]).to eq(product.id)
        expect(JSON.parse(response.body)["name"]).to eq(product.name)
        expect(JSON.parse(response.body)["price"]).to eq(product.price)
        expect(JSON.parse(response.body)["quantity"]).to eq(product.quantity)
        expect(JSON.parse(response.body)["description"]).to eq(product.description)
      end
    end

    context 'showing a non-existing product' do
      before do
        get "/api/v1/products/show/-1"
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe "/POST #create" do
    let(:admin) do
      create(:admin)
    end

    let(:type) do
      create(:type)
    end

    let(:params) do {
      name: "test_create",
      type_id: type.id,
      price: 15.55,
      quantity: "200g",
      description: "test_description"
    }
    end

    context 'logged in as admin with valid params' do
      before do
        post "/api/v1/products/create", params: { product: params }, headers: {
          'X-Admin-Token': admin.authentication_token,
          'X-Admin-Email': admin.email
        }
      end

      it { expect(response).to have_http_status(:created) }

      it 'creates the product' do
        new_product = Product.find_by(name: "test_create")
        expect(new_product).not_to be_nil
      end
    end

    context 'logged in as admin with invalid params' do
      before do
        post "/api/v1/products/create", params: { 
          product: {
            name: "test_create",
            type_id: type.id,
            price: nil,
            quantity: "200g",
            description: nil
          } 
        }, headers: {
          'X-Admin-Token': admin.authentication_token,
          'X-Admin-Email': admin.email
        }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it 'does not create the product' do
        new_product = Product.find_by(name: "test_create")
        expect(new_product).to be_nil
      end

    end

  end

  describe "/UPDATE #update" do
    let(:product) { create(:product) }

    let(:admin) do
      create(:admin)
    end

    let(:params) do 
      {
        name: "test_update",
        price: 100,
        quantity: "500g",
        description: "updated_description"
      }
    end

    context 'logged in as admin with valid params' do
      before do
        patch "/api/v1/products/update/#{product.id}", params: { product: params }, headers: {
          'X-Admin-Token': admin.authentication_token,
          'X-Admin-Email': admin.email
        }
      end

      it { expect(response).to have_http_status(:ok) }

      it 'updates the product' do
        updated_product = Product.find_by(id: product.id)
        expect(updated_product.name).to eq("test_update")
        expect(updated_product.price).to eq(100)
        expect(updated_product.quantity).to eq("500g")
        expect(updated_product.description).to eq("updated_description")
      end
    end

    context 'logged in as admin with invalid params' do
      before do
        patch "/api/v1/products/update/#{product.id}", params: { 
          product: {
            name: nil,
            price: 100,
            quantity: "500g",
            description: "updated_description"
          } 
        }, headers: {
          'X-Admin-Token': admin.authentication_token,
          'X-Admin-Email': admin.email
        }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it 'does not update the product' do
        updated_product = Product.find_by(id: product.id)
        expect(updated_product.name).not_to be_nil
        expect(updated_product.price).not_to be(100)
        expect(updated_product.quantity).not_to be("500g")
        expect(updated_product.description).not_to be("updated_description")
      end

    end
  end

  describe "/DELETE #delete" do
    let(:product) { create(:product) }
    let(:admin) { create(:admin) }

    context 'logged in as admin when product exist' do
      before do
        delete "/api/v1/products/delete/#{product.id}", headers: {
          'X-Admin-Token': admin.authentication_token,
          'X-Admin-Email': admin.email
        }
      end

      it { expect(response).to have_http_status(:ok) }

      it 'deletes the product' do
        deleted_product = Product.find_by(id: product.id)
        expect(deleted_product).to be_nil
      end
    end

    context 'logged in as admin when product does not exist' do
      before do
        delete "/api/v1/products/delete/-1", headers: {
          'X-Admin-Token': admin.authentication_token,
          'X-Admin-Email': admin.email
        }
      end

      it { expect(response).to have_http_status(:not_found)}
    end
  end
end
