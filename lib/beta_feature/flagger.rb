require 'set'

module BetaFeature

  module Flagger
    extend ActiveSupport::Concern

    module ClassMethods
      def flagger
        return if include_modules.include?(::BetaFeature::Flagger::BetaFeatureInstanceMethods)

        include ::BetaFeature::Flagger::BetaFeatureInstanceMethods

        has_one :beta_feature_setting, class: "BetaFeature::Setting"
      end
    end

    module InstanceMethods
      def can_access_beta?(*keys)
        keys = keys.map(&:to_s)
        validate_beta_feature_name(*keys)
        keys.all {|key| all_betas.include?(key) }
      end

      # add feature flags.
      def enable_beta!(keys)
        validate_beta_feature_name(*keys)

        betas = (beta_feature_setting.betas + keys).uniq
        beta_feature_setting.update(betas: betas)

        flush_beta_cache
      end

      #remove feature flags
      def remove_beta!(keys)
        validate_beta_feature_name(*keys)

        betas = (beta_feature_setting.betas - keys).uniq
        beta_feature_setting.update(betas: betas)

        flush_beta_cache
      end

      def all_betas
        @__all_betas__ ||= begin 
          setting = beta_feature_setting || create_beta_feature_setting
          setting.betas.to_set
        end
      end


      private

      def validate_beta_feature_name(*keys)
        # TODO
      end

      def flush_beta_cache
        remove_instance_variable(:@__all_betas__)
      end
    end
  end
end