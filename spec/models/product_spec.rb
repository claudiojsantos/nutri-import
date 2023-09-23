require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }
  it { is_expected.to be_stored_in(database: 'import_products', collection: 'products') }
  it { is_expected.to have_field(:code) }
  it { is_expected.to have_fields(:code, :nutriscore_score).of_type(Integer) }
  it { is_expected.to have_fields(:imported_t).of_type(DateTime) }
  it { is_expected.to have_fields(:created_t, :last_modified_t).of_type(Time) }
  it {
    is_expected.to have_fields(:status, :url, :creator, :product_name, :quantity, :brands, :categories, :labels,
                               :cities, :purchase_places, :stores, :ingredients_text, :traces, :serving_size,
                               :nutriscore_grade, :main_category, :image_url).of_type(String)
  }
end
