require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'database_cleaner'
  require 'capybara/rspec'
  require 'ffaker'
  require 'factory_girl_rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    Capybara.javascript_driver = :webkit
    config.include FactoryGirl::Syntax::Methods
    config.include Devise::TestHelpers, type: :controller
    config.include Capybara::DSL

    config.infer_base_class_for_anonymous_controllers = false

    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
end

Spork.each_run do
  FactoryGirl.factories.clear
  FactoryGirl.reload
end