source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.5'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

# mongo
gem 'mongo', '~> 2'
gem 'mongoid', '~> 8.1', '>= 8.1.2'

# paginacao
gem 'kaminari-mongoid'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'byebug', '~> 11.1', '>= 11.1.3'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker', '~> 3.1', '>= 3.1.1'
  gem 'mongoid-rspec'
  gem 'pry-byebug', '~> 3.10', '>= 3.10.1'
  gem 'rspec', '~> 3.12'
  gem 'rspec-expectations', '~> 3.12', '>= 3.12.2'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'
  gem 'rubocop', '~> 1.46'
  gem 'rubocop-performance', '~> 1.16'
  gem 'rubocop-rails', '~> 2.18'
  gem 'rubocop-rspec', '~> 2.18', '>= 2.18.1'
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'annotate'
end

group :test do
  gem 'simplecov', require: false
  gem 'webmock'
end
