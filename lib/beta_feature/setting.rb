
module BetaFeature
  class Setting < ::ActiveRecord::Base
    self.table_name = "beta_feature_settings"

    validates :betable_type, presence: true
    validates :betable_id, presence: true, uniqueness: { scope: :betable_type }

    belongs_to :betable, polymorphic: true


    def clean_invalid_betas!
      #TODO
    end
  end
end