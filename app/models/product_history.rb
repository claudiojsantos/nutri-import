class ProductHistory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :imported_at, type: Time
  field :import_sources, type: String
  field :imported_by, type: String
  field :notes, type: String
  field :product_data, type: Hash

  store_in database: 'import_products', collection: 'product_histories'
end
