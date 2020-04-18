
module BetaFeature
  class Setting < ::ActiveRecord::Base
    belongs_to :owner, polymorphic: true


    def clean_invalid_betas!
      #TODO
    end
  end
end