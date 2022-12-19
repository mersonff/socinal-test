source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails"
gem "pg"
gem "puma"
gem "bootsnap", require: false
gem "online_migrations"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "bundler-audit"
  gem "brakeman"
end

group :test do
  gem "simplecov"
  gem "simplecov-lcov"
end
