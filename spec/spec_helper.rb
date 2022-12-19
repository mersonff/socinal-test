# frozen_string_literal: true

require 'simplecov'
require 'simplecov-lcov'

SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new [
  SimpleCov::Formatter::LcovFormatter,
  SimpleCov::Formatter::HTMLFormatter
]
SimpleCov.start 'rails' do
  enable_coverage :branch
  primary_coverage :branch
end

RSpec.configure do |config|
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.profile_examples = 10
end
