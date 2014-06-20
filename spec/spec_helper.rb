require 'rubygems'
require 'bundler/setup'
require 'rspec/logger'
require 'logger'
require 'tempfile'

RSpec.configure do |config|
  config.around(:each) do |example|
    RSpec::Logger.new(example).log
  end
end
