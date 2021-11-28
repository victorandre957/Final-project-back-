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

  describe "/GET #logout" do
    let(:user) do
      create(:user)
    end

    context 'logged in as user' do
      before do
        get '/user/logout', headers: {
          'X-User-Token': user.authentication_token,
          'X-User-Email': user.email
        }
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'not logged in as user' do
      before do
        get '/user/logout'
      end

      it 'returns a failure response' do
        expect(response).to redirect_to authentication_failure_path
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

      it 'updates the user' do
        new_user = User.find_by(email: "test@test.com")
        expect(new_user).to be_nil
      end

    end
  end
  
  describe "/PATCH #update" do

    let(:user) { create(:user) }
    let(:user2) { create(:user, email: "test2@test") }

    let(:params) do 
      {
        name: "testUpdate",
        email: "test@update",
        password: "updated"
      }
    end

    context 'logged in as user with valid params' do
      before do
        patch "/user/update/#{user.id}", params: { user: params }, headers: {
          'X-User-Token': user.authentication_token,
          'X-User-Email': user.email
        }
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:ok)
      end
      
      it 'updates the user' do
        updated_user = User.find_by(id: user.id)
        expect(updated_user).not_to be_nil
        expect(updated_user.name).to eq("testUpdate")
      end
    end

    context 'logged in as user with invalid params' do
      before do
        patch "/user/update/#{user.id}", params: {
          name: nil
        }, headers: {
          'X-User-Token': user.authentication_token,
          'X-User-Email': user.email
        }
      end

      it 'returns a failure response' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
      
      it 'does not update the user' do
        updated_user = User.find_by(id: user.id)
        expect(updated_user).not_to be_nil
        expect(updated_user.name).not_to eq("testUpdate")
      end
    end

    context 'logged in as user trying to update another user' do
      before do
        patch "/user/update/#{user2.id}", params: params, headers: {
          'X-User-Token': user.authentication_token,
          'X-User-Email': user.email
        }
      end

      it 'returns a unauthorized response' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'not logged in as user' do
      before do
        patch "/user/update/#{user.id}", params: params
      end

      it 'returns a failure response' do
        expect(response).to redirect_to authentication_failure_path
      end
    end

    
  end

  describe "/DELETE #delete" do
    let(:user) do
      create(:user)
    end
    let(:user2) do
      create(:user, email: "test2@test.com")
    end

    context 'logged in as user with a existing user id' do
      before do
        delete "/user/delete/#{user.id}", headers: {
          'X-User-Token': user.authentication_token,
          'X-User-Email': user.email
        }
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:ok)
      end
 
      it 'deletes the user' do
        deleted_user = User.find_by(email: "test@test.com")
        expect(deleted_user).to be_nil
      end
    end

    context 'logged in as user and trying to delete a different user' do
      before do
        delete "/user/delete/#{user2.id}", headers: {
          'X-User-Token': user.authentication_token,
          'X-User-Email': user.email
        }
      end

      it 'returns an unauthorized response' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'logged in as user with a non-existing user id' do
      before do
        delete "/user/delete/-1", headers: {
          'X-User-Token': user.authentication_token,
          'X-User-Email': user.email
        }
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'not logged in as user' do
      before do
        delete "/user/delete/#{user.id}"
      end

      it 'returns a failure response' do
        expect(response).to redirect_to authentication_failure_path
      end
    end
  end
end
