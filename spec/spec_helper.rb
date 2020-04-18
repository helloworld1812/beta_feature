ENV['RAILS_ENV'] = 'test'

require 'bundler/setup'
require 'beta_feature'
require 'rails_app/config/environment'
require 'rspec/rails'
require 'pry'

RSpec.configure do |config|
  # config.use_transactional_fixtures = false if Rails.version.start_with?('4.')
  # config.use_transactional_tests = false if config.respond_to?(:use_transactional_tests=)
end


db_config = ActiveRecord::Base.configurations[Rails.env].clone
db_type = db_config['adapter']
db_name = db_config.delete('database')

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.establish_connection
