class ProductHistory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :product_code, type: String
  field :imported_t, type: Time
  field :import_sources, type: String
  field :import_by, type: String
  field :notes, type: String
  field :product_data, type: Hash

  store_in database: 'import_products', collection: 'product_histories'
end
