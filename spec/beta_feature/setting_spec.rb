require 'spec_helper'

# SingleCov.covered!

describe BetaFeature::Setting do
  let(:user)    { User.create first_name: "Ryan" }
  let(:setting) { user.send(:find_or_create_beta_feature_setting) }

  describe "#validates" do
    it 'should be unique' do
      new_setting = setting.dup
      expect(new_setting.valid?).to eq(false)
    end

    it 'should be present' do
      setting = BetaFeature::Setting.new
      setting.valid?

      expect(setting.errors["betable_type"].first).to eq("can't be blank")
      expect(setting.errors["betable_id"].first).to eq("can't be blank")
    end
  end
end