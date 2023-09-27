class HealthCheck
  include Mongoid::Document
  include Mongoid::Timestamps

  field :message, type: String
  field :last_cron_run, type: DateTime
  field :uptime, type: String
  field :memory_usage, type: String

  store_in database: 'import_products', collection: 'health_checks'
end
