class Api::V1::FavouriteController < ApplicationController
  acts_as_token_authentication_handler_for User

  def index
    favourites = Favourite.all
    render json: favourites, status: :ok
  end

  def show
    favourite = Favourite.find(params[:id])
    render json: favourite, status: :found
  rescue StandardError
    head(:not_found)
  end

  def create
    favourite_params = Favourite.new(types_params)
    favourite_params.save!
    render json: favourite_params, status: :created
  rescue StandardError => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  def update
    favourite = Favourite.find(params[:id])
    language.update!(types_params)
    render json: favourite, status: :accepted
  rescue StandardError => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  def delete
    favourite = Favourite.find(params[:id])
    favourite.destroy!
    render json: favourite, status: :accepted
  rescue StandardError => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  private

  def favourite_params
    params.require(:type).permit(
      :name,
      :user_id,
      :product_id
    )
  end
end
