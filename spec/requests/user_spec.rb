require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "/GET #login" do
    before do
      create(:user)
    end

    let(:params) do 
      {
        email: "test@test.com",
        password: "12345678",
      }
    end
    
    context 'with correct params' do
      before do
        get "/user/login", params: params
      end

      it 'returns user information in a json' do
        expect(JSON.parse(response.body)["email"]).to eq("test@test.com")
        expect(JSON.parse(response.body)["name"]).to eq("test")
      end

      it 'returns a valid authentication token' do
        expect(JSON.parse(response.body)["authentication_token"]).not_to be_nil
      end

      # it 'is logged in' do
      #   expect(current_user).to be_valid
      # end
    end

    context 'with incorrect email' do
      before do
        get "/user/login", params: {
          email: "test@wrong.com",
          password: "12345678"
        }
      end

      it 'returns a failure response' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with incorrect password' do
      before do
        get "/user/login", params: {
          email: "test@test.com",
          password: "wrongpassword"
        }
      end

      it 'returns a failure response' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

  end
  describe "/POST #create" do

    let(:params) do 
      {
        email: "test@test.com",
        password: "12345678",
        password_confirmation: "12345678",
        name: "test"
      }
    end

    context 'with valid params' do
      
      before do
        post "/user/create", params: { user: params}
      end

      it 'returns a success response' do
       expect(response).to have_http_status(:created)
      end

      it 'creates the user' do
        new_user = User.find_by(email: "test@test.com")
        expect(new_user).not_to be_nil
      end
    end

    context 'with invalid params' do
      before do
        post "/user/create", params: { 
          user: {
            email: nil,
            password: nil,
            password_confirmation: nil,
            name: nil
          }
        }
      end

      it 'returns a failure response' do
       expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'creates the user' do
        new_user = User.find_by(email: "test@test.com")
        expect(new_user).to be_nil
      end

    end
  end
  
end
