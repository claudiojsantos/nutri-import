class ProductsController < ApplicationController
  include ActionController::MimeResponds
  include Paginatable

  def index
    @products = Product.all.page(params[:page]).per(10)
  end

  def show
    @product = Product.find_by(code: params[:code])
  end

  def update
    @product = Product.find_by(code: params[:code])

    return render json: { errors: 'Produto inexistente' }, status: :not_found if @product.nil?

    @service = Product::UpdateService.new(@product, product_params)

    if @service.call
      render json: { message: 'Produto Atualizado' }, status: :ok
    else
      render json: { errors: @service.errors }, status: :unprocessable_entity
    end
  end

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

  def product_params
    params.require(:product).permit(
      :status, :imported_t, :url, :creator, :created_t, :last_modified_t, :product_name, :quantity,
      :brands, :categories, :labels, :cities, :purchase_places, :stores, :ingredients_text, :traces,
      :serving_size, :serving_quantity, :nutriscore_score, :nutriscore_grade, :main_category, :image_url
    )
  end
end
