require 'rails_helper'

RSpec.describe 'HealthChecks', type: :request do
  describe 'GET /' do
    context 'when the database is functioning properly' do
      it 'returns status ok and the health message' do
        get '/'
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['message']).to eq('Health Check')
        expect(json['last_cron_run']).not_to be_nil
        expect(json['uptime']).not_to be_nil
        expect(json['memory_usage']).not_to be_nil
      end
    end

    context 'when a database error occurs during creation' do
      before do
        allow(HealthCheck).to receive(:create).and_raise(StandardError.new('Database Creation Error'))
      end

      it 'returns internal server error with appropriate message' do
        get '/'
        expect(response).to have_http_status(:internal_server_error)
        json = JSON.parse(response.body)
        expect(json['status']).to eq('Error')
        expect(json['message']).to eq('Database Creation Error')
      end
    end

    context 'when a database error occurs during reading' do
      before do
        allow(HealthCheck).to receive(:first).and_raise(StandardError.new('Database Reading Error'))
      end

      it 'returns internal server error with appropriate message' do
        get '/'
        expect(response).to have_http_status(:internal_server_error)
        json = JSON.parse(response.body)
        expect(json['status']).to eq('Error')
        expect(json['message']).to eq('Database Reading Error')
      end
    end

    context 'when there is a validation error' do
      before do
        allow_any_instance_of(HealthCheck).to receive(:valid?).and_return(false)
      end

      it 'returns internal server error with generic database error message' do
        get '/'
        expect(response).to have_http_status(:internal_server_error)
        json = JSON.parse(response.body)
        expect(json['status']).to eq('Error')
        expect(json['message']).to eq('Erro na Leitura ou escrita no Banco de Dados')
      end
    end

    context 'when read_health_check is not present' do
      before do
        allow(HealthCheck).to receive(:first).and_return(nil)
      end

      it 'returns internal server error with generic database error message' do
        get '/'
        expect(response).to have_http_status(:internal_server_error)
        json = JSON.parse(response.body)
        expect(json['status']).to eq('Error')
        expect(json['message']).to eq('Erro na Leitura ou escrita no Banco de Dados')
      end
    end
  end
end
