require 'rails/generators'
require 'rails/generators/migration'
require 'active_record'
require 'rails/generators/active_record'
require 'generators/beta_feature/migration'
require 'generators/beta_feature/migration_helper'


module BetaFeature
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      include BetaFeature::Generators::MigrationHelper
      extend BetaFeature::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)

      def copy_migrateion
        migration_template 'install.rb', 'db/migrate/install_beta_feature.rb'
        copy_file 'beta_features.yml', 'config/beta_features.yml'
      end
    end
  end
end
