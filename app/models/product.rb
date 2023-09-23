class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :code, type: Integer
  field :status, type: String
  field :imported_t, type: DateTime
  field :url, type: String
  field :creator, type: String
  field :created_t, type: Time
  field :last_modified_t, type: Time
  field :product_name, type: String
  field :quantity, type: String
  field :brands, type: String
  field :categories, type: String
  field :labels, type: String
  field :cities, type: String
  field :purchase_places, type: String
  field :stores, type: String
  field :ingredients_text, type: String
  field :traces, type: String
  field :serving_size, type: String
  field :serving_quantity, type: Float
  field :nutriscore_score, type: Integer
  field :nutriscore_grade, type: String
  field :main_category, type: String
  field :image_url, type: String

  store_in database: 'import_products', collection: 'products'
end
