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
        expect(json_response['code']).to eq('123')
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

  describe 'PUT /products/:code' do
    let!(:product) { create(:product) }
    let(:params) { { product_name: 'Novo Produto' } }
    let(:url) { "/products/#{product.code}" }
    let(:params_body) { { product: params } }

    context 'when the post is successfully updated' do
      it 'returns a success response' do
        put url, params: params_body.to_json, headers: { 'Content-Type' => 'application/json' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Produto Atualizado')
      end
    end

    context 'when the post is not found' do
      let(:params) { { code: -1, product: { product_name: 'Novo Produto' } } }
      let(:url) { "/products/#{params[:code]}" }
      let(:params_body) { { postagem: params[:product] } }

      it 'returns an error response' do
        put url, headers: { 'Content-Type' => 'application/json' }, params: params_body.to_json
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end

    context 'when parameters are invalid' do
      let!(:product) { create(:product) }
      let(:params) { { product_name: '' } }
      let(:url) { "/products/#{product.code}" }
      let(:params_body) { { product: params }.to_json }

      it 'returns an error response' do
        put url, headers: { 'Content-Type' => 'application/json' }, params: params_body
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end
end
