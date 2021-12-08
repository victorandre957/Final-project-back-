require 'rails_helper'

RSpec.describe "Api::V1::Types", type: :request do
  describe "/GET #index" do
    before do
      create(:type)
      create(:type, name: "test2")
      get '/api/v1/types/'
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
    let(:type) do
      create(:type)
    end
    context 'showing an existing type' do
      before do
        get "/api/v1/types/show/#{type.id}"
      end

      it { expect(response).to have_http_status(:ok) }

      it 'returns with json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns with the correct type' do
        expect(JSON.parse(response.body)["id"]).to eq(type.id)
        expect(JSON.parse(response.body)["name"]).to eq(type.name)
      end
    end

    context 'showing a non-existing type' do
      before do
        get "/api/v1/types/show/-1"
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe "/POST #create" do
    let(:admin) do
      create(:admin)
    end

    let(:params) do {
      name: "test_create",
    }
    end

    context 'logged in as admin with valid params' do
      before do
        post "/api/v1/types/create", params: { type: params }, headers: {
          'X-Admin-Token': admin.authentication_token,
          'X-Admin-Email': admin.email
        }
      end

      it { expect(response).to have_http_status(:created) }

      it 'creates the type' do
        new_type = Type.find_by(name: "test_create")
        expect(new_type).not_to be_nil
      end
    end

    context 'logged in as admin with invalid params' do
      before do
        post "/api/v1/types/create", params: { 
          type: {
            name: nil,
          } 
        }, headers: {
          'X-Admin-Token': admin.authentication_token,
          'X-Admin-Email': admin.email
        }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

    end

    context 'not logged in as admin' do
      before do
        post "/api/v1/types/create", params: { type: params }
      end

      it 'returns a failure response' do
        expect(response).to redirect_to authentication_failure_path
      end
    end
  end

  describe "/UPDATE #update" do
    let(:type) { create(:type) }

    let(:admin) do
      create(:admin)
    end

    let(:params) do 
      {
        name: "test_update",
      }
    end

    context 'logged in as admin with valid params' do
      before do
        patch "/api/v1/types/update/#{type.id}", params: { type: params }, headers: {
          'X-Admin-Token': admin.authentication_token,
          'X-Admin-Email': admin.email
        }
      end

      it { expect(response).to have_http_status(:ok) }

      it 'updates the type' do
        updated_type = Type.find_by(id: type.id)
        expect(updated_type.name).to eq("test_update")
      end
    end

    context 'logged in as admin with invalid params' do
      before do
        patch "/api/v1/types/update/#{type.id}", params: { 
          type: {
            name: nil
          } 
        }, headers: {
          'X-Admin-Token': admin.authentication_token,
          'X-Admin-Email': admin.email
        }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it 'does not update the type' do
        updated_type = Type.find_by(id: type.id)
        expect(updated_type.name).not_to be_nil
      end
    end

    context 'not logged in as admin' do
      before do
        patch "/api/v1/types/update/#{type.id}", params: { type: params }
      end

      it 'returns a failure response' do
        expect(response).to redirect_to authentication_failure_path
      end
    end
  end

  describe "/DELETE #delete" do
    let(:type) { create(:type) }
    let(:admin) { create(:admin) }

    context 'logged in as admin when type exist' do
      before do
        delete "/api/v1/types/delete/#{type.id}", headers: {
          'X-Admin-Token': admin.authentication_token,
          'X-Admin-Email': admin.email
        }
      end

      it { expect(response).to have_http_status(:ok) }

      it 'deletes the type' do
        deleted_type = Type.find_by(id: type.id)
        expect(deleted_type).to be_nil
      end
    end

    context 'logged in as admin when type does not exist' do
      before do
        delete "/api/v1/types/delete/-1", headers: {
          'X-Admin-Token': admin.authentication_token,
          'X-Admin-Email': admin.email
        }
      end

      it { expect(response).to have_http_status(:not_found)}
    end

    context 'not logged in as admin' do
      before do
        delete "/api/v1/types/delete/#{type.id}"
      end

      it 'returns a failure response' do
        expect(response).to redirect_to authentication_failure_path
      end
    end
  end
end
