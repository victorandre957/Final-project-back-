class UserController < ApplicationController
  acts_as_token_authentication_handler_for User, only: [:logout, :show, :delete, :update]
  def login
    user = User.find_by!(email: params[:email])
    if user.valid_password?(params[:password])
      render json: user, status: :ok
    else
      head(:unauthorized)
    end
  rescue StandardError => e
    render json: {message: e.message}, status: :not_found
  end

  def show
    render json: current_user, status: :ok
  end

  def logout
    current_user.update!(authentication_token: nil)
    render json: {message: "You have successfully logout."}, status: :ok
  rescue StandardError => e
    render json: {message: e.message}, status: :bad_request
  end

  def create
    user = User.new(user_params)
    user.save!
    render json: user, status: :created
  rescue StandardError => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  def update
    user = User.find(params[:id])
    if current_user.id === user.id then
      User.update!(user_params)
      render json: user, status: :ok
    else
      render json: {message: "Você não pode atualizar a conta de outro usuário"}, status: :unauthorized
    end
  rescue StandardError => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  def delete
    user = User.find(params[:id])
    if current_user.id === user.id then
      user.destroy!
      render json: user, status: :ok
    else
      render json: {message: "Você não pode deletar a conta de outro usuário"}, status: :unauthorized
    end
  rescue StandardError => e
    render json: {message: e.message}, status: :not_found
  end


  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :profile_picture
    )
  end
end
