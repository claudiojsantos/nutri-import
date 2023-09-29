class HealthChecksController < ApplicationController
  def health
    message = 'Health Check'
    last_cron_run = CronHistory.last&.created_at
    uptime = `uptime`.split(',')[0].split('up ')[1].strip
    memory_usage = CronHistory.last&.memory_after.to_i - CronHistory.last&.memory_before.to_i

    @health_check = {
      message:,
      last_cron_run:,
      uptime:,
      memory_usage:
    }

    if last_cron_run.present? && uptime.present?
      render :health, status: :ok
    else
      render json: { status: 'Error', message: 'Erro na Leitura ou Escrita no Banco de Dados' },
             status: :internal_server_error
    end
  rescue StandardError => e
    render json: { status: 'Error', message: e.message }, status: :internal_server_error
  end
end
