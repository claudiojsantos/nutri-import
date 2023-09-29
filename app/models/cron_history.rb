class CronHistory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :start_cron, type: DateTime
  field :finish_cron, type: DateTime
  field :memory_before, type: Integer
  field :memory_after, type: Integer
  field :time_elapsed, type: Float

  store_in database: 'import_products', collection: 'cron_histories'
end
