require 'spec_helper'

# SingleCov.covered!

describe BetaFeature do
  describe ".all_betas" do
    it 'should return all betas' do
      expect(BetaFeature.all_betas.count).to eq(3)
    end
  end

  describe ".in_progress" do
    it 'should return in_progress betas' do
      expect(BetaFeature.in_progress.count).to eq(2)
      expect(BetaFeature.in_progress.all? {|k, v| v["status"] == "in_progress"}).to eq(true)
    end
  end

  describe ".released" do
    it 'should return released betas' do
      expect(BetaFeature.released.count).to eq(1)
      expect(BetaFeature.released.all? {|k, v| v["status"] == "released"}).to eq(true)
    end
  end
end