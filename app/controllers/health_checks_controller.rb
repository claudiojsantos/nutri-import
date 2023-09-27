class HealthChecksController < ApplicationController
  def health
    health_check = HealthCheck.create(message: 'Health Check')

    last_cron_run = DateTime.now
    uptime = 'uptime'.strip
    memory_usage = 'free -m'.strip

    health_check = HealthCheck.new(
      message: 'Health Check',
      last_cron_run:,
      uptime:,
      memory_usage:
    )

    if health_check.valid?
      read_health_check = HealthCheck.first

      if read_health_check.present?
        render json: health_check.as_json, status: :ok
      else
        render json: { status: 'Error', message: 'Erro na Leitura ou escrita no Banco de Dados' },
               status: :internal_server_error
      end
    else
      render json: { status: 'Error', message: 'Erro na Leitura ou escrita no Banco de Dados' },
             status: :internal_server_error
    end
  rescue StandardError => e
    render json: { status: 'Error', message: e.message }, status: :internal_server_error
  end
end
