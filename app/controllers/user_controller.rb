class UserController < ApplicationController
  acts_as_token_authentication_handler_for User, only: :logout
  def login
    user = User.find_by!(email: params[:email])
    if user.valid_password?(params[:password])
      render json: user
    else
      head(:unauthorized)
    end
  rescue StandardError => e
    render json: {message: e.message}, status: :not_found
  end

  def logout
    current_user.update!(authentication_token: nil)
    render json: {message: "You have successfully logout."}, status: :ok
  rescue StandardError => e
    render json: {message: e.message}, status: :bad_request
  end
end
