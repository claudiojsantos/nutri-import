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

  describe 'validations' do
    it 'validates presence of code' do
      product = Product.new(code: nil)
      expect(product.valid?).to be_falsey
      expect(product.errors[:code]).to include("can't be blank")
    end

    it 'validates uniqueness of code' do
      existing_product = create(:product, code: '12345')
      new_product = build(:product, code: '12345')
      expect(new_product.valid?).to be_falsey
      expect(new_product.errors[:code]).to include('has already been taken')
    end

    it 'validates presence of product name' do
      product = Product.new(product_name: nil)
      expect(product.valid?).to be_falsey
      expect(product.errors[:product_name]).to include("can't be blank")
    end

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

    describe '#draft?' do
      let(:draft_product) { create(:product, status: 'draft') }
      let(:non_draft_product) do
        create(:product, status: 'published')
      end
      it 'returns true if the product is draft' do
        expect(draft_product.draft?).to be true
      end

      it 'returns false if the product is not draft' do
        expect(non_draft_product.draft?).to be false
      end
    end

    describe '#trash?' do
      let(:trash_product) { create(:product, status: 'trash') }
      let(:non_trash_product) do
        create(:product, status: 'published')
      end
      it 'returns true if the product is trash' do
        expect(trash_product.trash?).to be true
      end

      it 'returns false if the product is not trash' do
        expect(non_trash_product.trash?).to be false
      end
    end

    describe '#published?' do
      let(:published_product) { create(:product, status: 'published') }
      let(:non_published_product) { create(:product, status: 'draft') }

      it 'returns true if the product is published' do
        expect(published_product.published?).to be true
      end

      it 'returns false if the product is not published' do
        expect(non_published_product.published?).to be false
      end
    end
  end
end
