require 'rails/generators'

module BetaFeature
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def copy_migrateion
        copy_file 'beta_features.yml', 'config/beta_features.yml'
      end
    end
  end
end