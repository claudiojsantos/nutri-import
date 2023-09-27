require 'rails_helper'

RSpec.describe HealthCheck, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }

  it { is_expected.to have_fields(:message, :uptime, :memory_usage).of_type(String) }
  it { is_expected.to have_field(:last_cron_run).of_type(DateTime) }

  it { is_expected.to be_stored_in(database: 'import_products', collection: 'health_checks') }
end
