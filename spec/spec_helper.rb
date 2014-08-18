require 'bundler'
Bundler.setup(:test)
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'capybara/rspec'
require_relative '../app.rb'

RSpec.configuration.include Capybara::DSL
Capybara.app = Preview
