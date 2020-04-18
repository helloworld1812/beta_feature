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

# Pick mysql when ENV['DB'] == MYSQL
# Pick postgres when ENV['DB'] == POSTGRES
db_config = ActiveRecord::Base.configurations[Rails.env].clone
db_type = db_config['adapter']
db_name = db_config.delete('database')

adapter = ActiveRecord::Base.send("#{db_type}_connection", db_config)
adapter.recreate_database db_name, db_config.slice('charset').symbolize_keys

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.establish_connection


# Create tables
ActiveRecord::Schema.define do
  create_table :beta_feature_settings, force: true do |t|
    t.integer :betable_id, null: false
    t.string :betable_type, null: false
    t.string :betas, array: true, default: [], null: false
    t.timestamps
  end
  add_index :beta_feature_settings, [:betable_type, :betable_id], unique: true

  create_table :users, force: true do |t|
    t.string :first_name
    t.string :last_name
    t.integer :age
    t.timestamps
  end

  create_table :company, force: true do |t|
    t.string :name
    t.string :website
    t.timestamps
  end

  create_table :stores, force: true do |t|
    t.string :name
    t.string :location
    t.timestamps
  end

  create_table :groups, force: true do |t|
    t.string :name
    t.text   :description
    t.timestamps
  end
end
