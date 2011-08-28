require 'bundler'
Bundler.setup(:test)
require 'rspec'
require 'capybara/rspec'

Capybara.register_driver :selenium_chrome do |app|
    Capybara::Driver::Selenium.new(app, :browser => :chrome)
end
Capybara.javascript_driver = :selenium_chrome
