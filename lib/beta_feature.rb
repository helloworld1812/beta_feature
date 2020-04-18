require "beta_feature/version"
require "beta_feature/flagger"
require "beta_feature/setting"
require "beta_feature/error"

::ActiveRecord::Base.send :include, BetaFeature::Flagger
