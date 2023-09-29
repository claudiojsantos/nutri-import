require 'rails_helper'

RSpec.describe 'Health Checks', type: :request do
  describe 'GET /health' do
    context 'when uptime and last cron run are present' do
      let(:url) { '/' }

      before do
        allow(CronHistory).to receive_message_chain(:last, :created_at).and_return(Time.now)
        allow(CronHistory).to receive_message_chain(:last, :memory_after).and_return(5000)
        allow(CronHistory).to receive_message_chain(:last, :memory_before).and_return(4000)
      end

      it 'returns a success response' do
        get url
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to include('Health Check')
      end
    end

    context 'when uptime or last cron run is not present' do
      let(:url) { '/' }

      before do
        cron_history = double('CronHistory', created_at: Time.now, memory_after: 5000, memory_before: 4000)
        allow(CronHistory).to receive(:last).and_return(cron_history)
        allow(CronHistory).to receive_message_chain(:last, :created_at).and_return(nil)
      end

      it 'returns an internal server error' do
        get url
        expect(response).to have_http_status(:internal_server_error)
        expect(response.body).to include('Erro na Leitura ou Escrita no Banco de Dados')
      end
    end

    context 'when an error occurs' do
      let(:url) { '/' }

      before do
        allow(CronHistory).to receive(:last).and_raise(StandardError, 'An error occurred')
      end

      it 'returns an internal server error and the error message' do
        get url
        expect(response).to have_http_status(:internal_server_error)
        expect(response.body).to include('An error occurred')
      end
    end
  end
end
