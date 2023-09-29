class Product::UpdateService
  attr_reader :errors

  def initialize(products, params)
    @products = products
    @params = params
    @errors = []
  end

  def call
    return false unless @products

    if @products.update(@params) && @products.valid?
      true
    else
      @errors = @products.errors.full_messages
      false
    end
  end
end
