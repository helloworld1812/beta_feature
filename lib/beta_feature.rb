require 'active_record'
require 'active_support'
require 'yaml'

require "beta_feature/version"
require "beta_feature/flagger"
require "beta_feature/setting"
require "beta_feature/error"

module BetaFeature
  def self.all_betas
    @@all_betas ||= YAML.load_file("#{Rails.root}/config/beta_features.yml")
  end

  def self.in_progress
    @@in_progress_betas ||= all_betas.select {|k, v| v["status"] == 'in_progress'}
  end

  def self.released
    @@released_betas ||= all_betas.select {|k, v| v["status"] == 'released'}
  end
end

::ActiveRecord::Base.send :include, BetaFeature::Flagger
