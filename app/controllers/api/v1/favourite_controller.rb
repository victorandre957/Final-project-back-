class Api::V1::FavouriteController < ApplicationController
  acts_as_token_authentication_handler_for User

  def index
    favourites = current_user.favourites
    render json: favourites, status: :ok
  end

  def create
    favourite = Favourite.new(favourites_params)
    if current_user.id === favourite.user_id then
      favourite.save!
      render json: favourite, status: :created
    elsif favourite.user_id === nil then
      render json: {message: "unprocessable_entity" }, status: :unprocessable_entity
    else
      render json: { message: "Você não pode criar um favorito para outro usuário" }, status: :unauthorized
    end
  rescue StandardError => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  def update
    favourite = Favourite.find(params[:id])
    if current_user.id === favourite.user_id then
      favourite.update!(favourites_params)
      render json: favourite, status: :ok
    else
      render json: { message: "Você não pode atualizar o favorito de outro usuário" }, status: :unauthorized
    end
  rescue StandardError => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  def delete
    favourite = Favourite.find(params[:id])
    if current_user.id === favourite.user_id then 
      favourite.destroy!
      render json: favourite, status: :ok
    else
      render json: { message: "Você não pode deletar o favorito de outro usuário" }, status: :unauthorized
    end
  rescue StandardError => e
    render json: {message: e.message}, status: :not_found
  end

  def is_favourite
      if Favourite.find_by(user_id: current_user.id, product_id: params[:id])
        render json: true, status: :ok
      else
        render json: false, status: :ok
      end
    end

  private

  def favourites_params
    params.require(:favourite).permit(
      :name,
      :user_id,
      :product_id
    )
  end
end
