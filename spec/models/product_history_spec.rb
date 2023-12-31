require 'rails_helper'

RSpec.describe ProductHistory, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }
  it { is_expected.to be_stored_in(database: 'import_products', collection: 'product_histories') }
  it { is_expected.to have_fields(:import_sources, :imported_by, :notes).of_type(String) }
  it { is_expected.to have_field(:imported_at).of_type(Time) }
  it { is_expected.to have_field(:product_data).of_type(Hash) }
end
