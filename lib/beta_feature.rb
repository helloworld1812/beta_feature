require "beta_feature/version"
require "beta_feature/engine"
require "beta_feature/error"
require "beta_feature/flagger"

module BetaFeature
  def self.all_betas
    @@all_betas ||= YAML.load_file("#{Rails.root}/config/beta_features.yml").with_indifferent_access
  end

  def self.in_progress
    @@in_progress_betas ||= all_betas.select {|k, v| v["status"] == 'in_progress'}
  end

  def self.released
    @@released_betas ||= all_betas.select {|k, v| v["status"] == 'released'}
  end
end
