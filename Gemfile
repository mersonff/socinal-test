# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bootsnap', require: false
gem 'online_migrations'
gem 'pg'
gem 'puma'
gem 'rails'

group :development, :test do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-rails', '~> 2.16', '>= 2.16.1'
  gem 'rubocop-rspec', '~> 2.13', '>= 2.13.2'
end

group :test do
  gem 'simplecov'
  gem 'simplecov-lcov'
end
