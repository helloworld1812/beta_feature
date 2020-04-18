require 'set'

module BetaFeature

  module Flagger
    extend ::ActiveSupport::Concern

    module ClassMethods
      def flagger
        return if included_modules.include?(::BetaFeature::Flagger::BetaFeatureInstanceMethods)

        include ::BetaFeature::Flagger::BetaFeatureInstanceMethods

        has_one :beta_feature_setting, class_name: "BetaFeature::Setting", as: :betable
      end
    end

    module BetaFeatureInstanceMethods
      def can_access_beta?(*betas)
        betas = betas.map(&:to_s)
        validate_beta_name(*betas)
        betas.all? {|key| all_betas.include?(key) }
      end

      # add feature flags.
      def enable_beta!(*betas)
        betas = betas.map(&:to_s)
        validate_beta_name(*betas)
        betas = (find_or_create_beta_feature_setting.betas + betas).uniq
        beta_feature_setting.update(betas: betas)

        flush_beta_cache
      end

      #remove feature flags
      def remove_beta!(*betas)
        betas = betas.map(&:to_s)
        validate_beta_name(*betas)

        betas = (find_or_create_beta_feature_setting.betas - betas).uniq
        beta_feature_setting.update(betas: betas)

        flush_beta_cache
      end

      def all_betas
        @__all_betas__ ||= find_or_create_beta_feature_setting.betas.to_set
      end

      private

      def validate_beta_name(*betas)
        betas.each do |beta|
          if !BetaFeature.all_betas.key?(beta)
            msg = "Please define #{beta} in config/beta_features.yml"
            raise BetaFeature::BetaNotDefined.new(msg)
          end
        end
      end

      def find_or_create_beta_feature_setting
        beta_feature_setting || create_beta_feature_setting
      end

      def flush_beta_cache
        remove_instance_variable(:@__all_betas__) if defined? @__all_betas__
      end
    end
  end
end