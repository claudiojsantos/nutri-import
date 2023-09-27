FactoryBot.define do
  factory :health_check do
    message { 'Health Check' }
    last_cron_run { DateTime.now }
    uptime { 'uptime' }
    memory_usage { 'free -m' }
  end
end
