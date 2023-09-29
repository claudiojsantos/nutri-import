require 'rails_helper'

RSpec.describe CronHistory, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }

  it { is_expected.to have_fields(:start_cron, :finish_cron).of_type(DateTime) }
  it { is_expected.to have_fields(:memory_before, :memory_after).of_type(Integer) }
  it { is_expected.to have_fields(:time_elapsed).of_type(Float) }
end
