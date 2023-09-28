require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'GET /products' do
    let(:url) { '/products' }

    before do
      create_list(:product, 25)
    end

    context 'when exists product' do
      it 'when exists products' do
        get url
        expect(response).to have_http_status(:success)
      end
    end

    context 'when page param is greater than total pages' do
      it 'renders the last available page' do
        get url, params: { page: 8 }
        parsed_response = JSON.parse(response.body)

        expect(parsed_response['total_pages']).to eq(3)
      end
    end
  end

  describe 'GET /products/:code' do
    let!(:product) { create(:product, code: '123') }

    describe 'GET /products/:code' do
      it 'returns the product based on the code' do
        get "/products/#{product.code}"

        expect(response).to have_http_status(200)

        json_response = JSON.parse(response.body)
        expect(json_response['code']).to eq(123)
      end
    end
  end

  describe 'DELETE /products/:code' do
    let!(:product) { create(:product, code: '123') }
    let(:url) { "/products/#{product.code}" }

    context 'when the product exists' do
      it 'moves the product to trash' do
        delete url, params: { code: product.code }

        product.reload
        expect(product.status).to eq('trash')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the product does not exist' do
      it 'returns an error' do
        delete '/products/nonexistent'

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('Produto não encontrado')
      end
    end
  end

  # describe 'GET /update' do
  #   it 'returns http success' do
  #     get '/products/update'
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
