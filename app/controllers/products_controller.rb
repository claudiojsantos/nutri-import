class ProductsController < ApplicationController
  include ActionController::MimeResponds
  include Paginatable

  def index
    @products = Product.all.page(params[:page]).per(10)
  end

  def show
    @product = Product.find_by(code: params[:code])
  end

  def update; end

  def delete
    @product = Product.find_by!(code: params[:code])
    @product.update(status: 'trash')
    render json: { message: 'Produto excluído com sucesso' }, status: :ok
  rescue Mongoid::Errors::DocumentNotFound => e
    render json: { error: 'Produto não encontrado' }, status: :not_found
  end

  private

  def paginatable_model
    Product
  end
end
