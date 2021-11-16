class Api::V1::TypeController < ApplicationController
  acts_as_token_authentication_handler_for Admin, only: [:create, :delete, :update]

  def index
    types = Type.all
    render json: types, status: :ok
  end

  def show
    type = Type.find(params[:id])
    render json: type, status: :found
  rescue StandardError
    head(:not_found)
  end

  def create
    new_type = Type.new(types_params)
    new_type.save!
    render json: new_type, status: :created
  rescue StandardError => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  def update
    type = Type.find(params[:id])
    language.update!(types_params)
    render json: language, status: :accepted
  rescue StandardError => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  def delete
    type = Type.find(params[:id])
    type.destroy!
    render json: language, status: :accepted
  rescue StandardError => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  private

  def types_params
    params.require(:type).permit(
    :name
    )
  end
end
