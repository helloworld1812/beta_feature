require_dependency "beta_feature/application_controller"

module BetaFeature
  class ConfigurationsController < ApplicationController
    def index
      render json: BetaFeature.all_betas.to_json
    end
  end
end
