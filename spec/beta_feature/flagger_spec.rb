require 'spec_helper'

SingleCov.covered!

describe BetaFeature::Flagger do
  let(:user)    { Models::ActiveRecord::User.new first_name: "Ryan" }
  let(:company) { Models::ActiveRecord::Company.new first_name: "Ryan" }
  let(:group)   { Models::ActiveRecord::Group.new first_name: "Ryan" }



end