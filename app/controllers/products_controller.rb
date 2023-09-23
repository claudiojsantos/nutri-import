class ProductsController < ApplicationController
  include ActionController::MimeResponds
  include Paginatable

  def index
    @products = Product.all.page(params[:page]).per(10)
  end

  def show; end

  def update; end

  def delete; end

  private

  def paginatable_model
    Product
  end
end
