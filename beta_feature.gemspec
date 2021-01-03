require_relative "lib/beta_feature/version"

Gem::Specification.new do |spec|
  spec.name          = "beta_feature"
  spec.version       = BetaFeature::VERSION
  spec.authors       = ["Ryan Lv"]
  spec.email         = ["tech@workstream.is"]

  spec.summary       = %q{Rails feature toggle for trunk based development.}
  spec.description   =  spec.summary 
  spec.homepage      = "https://github.com/helloworld1812/beta_feature"
  spec.license       = "MIT"
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/helloworld1812/beta_feature"
  spec.metadata["changelog_uri"] = "https://github.com/helloworld1812/beta_feature/blob/master/CHANGELOG.md"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 4.0"
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'pg'
  spec.add_development_dependency 'factory_bot_rails'
  spec.add_development_dependency 'pry'

end
