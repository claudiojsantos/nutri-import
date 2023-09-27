if @product
  json.id @product.id.to_s
  json.code @product.code
  json.status @product.status
  json.imported_t @product.imported_t
  json.url @product.url
  json.creator @product.creator
  json.created_t @product.created_t
  json.last_modified_t @product.last_modified_t
  json.product_name @product.product_name
  json.quantity @product.quantity
  json.brands @product.brands
  json.categories @product.categories
  json.labels @product.labels
  json.cities @product.cities
  json.purchase_places @product.purchase_places
  json.stores @product.stores
  json.ingredients_text @product.ingredients_text
  json.traces @product.traces
  json.serving_size @product.serving_size
  json.serving_quantity @product.serving_quantity
  json.nutriscore_score @product.nutriscore_score
  json.nutriscore_grade @product.nutriscore_grade
  json.main_category @product.main_category
  json.image_url @product.image_url
else
  json.error 'Produto não encontrado'
end
