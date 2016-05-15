require 'rubygems'
require 'bundler/setup'
require 'yaml'
require 'erb'
require 'rspec/retry'
require 'require_all'
require 'pp'

Bundler.require :default
require 'active_support'
require 'active_support/core_ext'

require_rel 'helpers'
# require_rel '../../utils'

some_app_spec_helper = SomeAppServer.new('8080')

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.default_formatter = 'doc'
  config.order = :random

  config.verbose_retry = true
  config.display_try_failure_messages = true
  config.example_status_persistence_file_path = 'examples.txt'

  config.before :suite do
    some_app_spec_helper.start
  end

  config.after :suite do
    some_app_spec_helper.stop
  end
end

def get(url)
  response = HTTParty.get(url)

  JSON.parse(
      response.body,
      symbolize_names: true)
end
