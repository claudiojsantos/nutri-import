require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }
  it { is_expected.to be_stored_in(database: 'import_products', collection: 'products') }
  it { is_expected.to have_fields(:nutriscore_score).of_type(Integer) }
  it { is_expected.to have_fields(:imported_t).of_type(DateTime) }
  it { is_expected.to have_fields(:created_t, :last_modified_t).of_type(Time) }
  it {
    is_expected.to have_fields(:code, :status, :url, :creator, :product_name, :quantity, :brands, :categories, :labels,
                               :cities, :purchase_places, :stores, :ingredients_text, :traces, :serving_size,
                               :nutriscore_grade, :main_category, :image_url).of_type(String)
  }

  describe 'enums of status' do
    let(:draft_product) { create(:product, status: 'draft') }
    let(:published_product) { create(:product, status: 'published') }
    let(:trash_product) { create(:product, status: 'trash') }
    let(:other_product) { build(:product, status: 'other') }

    it 'is valid with draft status' do
      expect(draft_product).to be_valid
    end

    it 'is valid with published status' do
      expect(published_product).to be_valid
    end

    it 'is valid with trash status' do
      expect(trash_product).to be_valid
    end

    it 'is invalid with other status' do
      expect(other_product).to be_invalid
    end
  end
end
