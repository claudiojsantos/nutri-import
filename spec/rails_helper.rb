require 'spec_helper'
require 'simplecov'

SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Mongoid::Matchers, type: :model
  config.use_active_record = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:each) do
    Product.delete_all
  end
end
