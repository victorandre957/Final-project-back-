class Api::V1::ProductController < ApplicationController
  acts_as_token_authentication_handler_for Admin, only: [:create, :delete, :update]

  def index
    products = Product.all
    render json: products, status: :ok
  end

  def show
    product = Product.find(params[:id])
    render json: product, status: :found
  rescue StandardError
    head(:not_found)
  end

  def create
    product = Product.new(product_params)
    product.save!
    render json: product, status: :created
  rescue StandardError => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  def update
    product = Product.find(params[:id])
    product.update!(product_params)
    render json: product, status: :ok
  rescue StandardError => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  def delete
    product = Product.find(params[:id])
    product.destroy!
    render json: product, status: :ok
  rescue StandardError => e
    render json: {message: e.message}, status: :not_found
  end


  private

  def product_params
    params.require(:product).permit(
      :name,
      :type_id,
      :price,
      :quantity,
      :description
    )
  end
end
