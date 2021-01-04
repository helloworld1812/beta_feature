module BetaFeature
  class Engine < ::Rails::Engine
    isolate_namespace BetaFeature

    initializer :append_migrations do |app|
      unless app.root.to_s.match(root.to_s)
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot
      g.factory_bot dir: 'spec/factories'
      g.assets false
      g.helper false
    end

    config.after_initialize do
      ::ActiveRecord::Base.send :include, BetaFeature::Flagger
    end
  end
end
