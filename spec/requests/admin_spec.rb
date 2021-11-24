require 'rails_helper'

RSpec.describe "Admins", type: :request do
  describe "/GET #login" do
    before do
      create(:admin)
    end

    let(:params) do 
      {
        email: "boss@teste",
        password: "123456",
      }
    end
    
    context 'with correct params' do
      before do
        get "/admin/login", params: params
      end

      it 'returns admin information in a json' do
        expect(JSON.parse(response.body)["email"]).to eq("boss@teste")
      end

      it 'returns a valid authentication token' do
        expect(JSON.parse(response.body)["authentication_token"]).not_to be_nil
      end

      # it 'is logged in' do
      #   expect(current_admin).to be_valid
      # end
    end

    context 'with incorrect email' do
      before do
        get "/admin/login", params: {
          email: "boss@wrong",
          password: "123456"
        }
      end

      it 'returns a failure response' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with incorrect password' do
      before do
        get "/admin/login", params: {
          email: "boss@teste",
          password: "wrongpassword"
        }
      end

      it 'returns a failure response' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
