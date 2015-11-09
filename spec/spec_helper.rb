require 'bundler'
Bundler.setup(:test)
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
require 'capybara/poltergeist'
require 'capybara/rspec'
require_relative '../app.rb'

Capybara.javascript_driver = :poltergeist
RSpec.configuration.include Capybara::DSL
Capybara.app = Preview
