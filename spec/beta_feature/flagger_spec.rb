require 'spec_helper'

# SingleCov.covered!

describe BetaFeature::Flagger do
  let(:user)    { User.create first_name: "Ryan" }
  let(:company) { Company.create(name: "Workstream") }
  let(:group)   { Group.create(name: "i-Running") }

  describe '#can_access_beta?' do
    it 'should return false' do
      expect(user.can_access_beta?(:dark_mode)).to eq(false)
      expect(user.can_access_beta?(:dark_mode, :landing_page_ux_improvement)).to eq(false)
    end

    it 'should return true' do
      user.enable_beta!("dark_mode", "landing_page_ux_improvement")

      expect(user.can_access_beta?(:dark_mode)).to eq(true)
      expect(user.can_access_beta?("dark_mode")).to eq(true)
      expect(user.can_access_beta?(:landing_page_ux_improvement)).to eq(true)
      expect(user.can_access_beta?("landing_page_ux_improvement")).to eq(true)
      expect(user.can_access_beta?(:dark_mode, :landing_page_ux_improvement)).to eq(true)
    end

    it 'should raise error' do
      expect { user.can_access_beta?(:beta_doesnt_exist) }.to raise_error(BetaFeature::BetaNotDefined)
    end

  end

  describe '#enable_beta!' do
    it 'should successfully enable a beta when passing a string argument' do
      user.enable_beta!("dark_mode")
      expect(user.can_access_beta?(:dark_mode)).to eq(true)
    end

    it 'should successfully enable a beta when passing a symbol argument' do
      user.enable_beta!(:dark_mode)
      expect(user.can_access_beta?(:dark_mode)).to eq(true)
    end

    it 'should be able to access this beta after enabling a beta' do
      expect(user.can_access_beta?(:dark_mode)).to eq(false)
      user.enable_beta!(:dark_mode)
      expect(user.can_access_beta?(:dark_mode)).to eq(true)
    end

    it 'should flush instance variable cache after enabling a beta' do
      expect(user).to receive(:flush_beta_cache)
      user.enable_beta!(:dark_mode)
    end

    it 'should raise an error when enabling an invalid beta' do
      expect { user.enable_beta!(:beta_doesnt_exist) }.to raise_error(BetaFeature::BetaNotDefined)
    end
  end

  describe '#remove_beta!' do
    it 'should not be able to access this beta after removing a beta' do
      user.enable_beta!(:dark_mode)
      expect(user.can_access_beta?(:dark_mode)).to eq(true)

      user.remove_beta!(:dark_mode)
      expect(user.can_access_beta?(:dark_mode)).to eq(false)
    end

    it 'should raise an error when removing an invalid beta' do
      expect { user.remove_beta!(:beta_doesnt_exist) }.to raise_error(BetaFeature::BetaNotDefined)
    end

    it 'should remove a beta when passing a string argument' do
      expect { user.enable_beta!("dark_mode") }.not_to raise_error
    end

    it 'should remove a beta when passing a symbol argument' do
      expect { user.enable_beta!(:dark_mode) }.not_to raise_error
    end

    it 'should flush instance variable cache after removing a beta' do
      expect(user).to receive(:flush_beta_cache)
      user.remove_beta!(:dark_mode)
    end
  end

  describe '#all_betas' do
    it 'should retrieve instance variable cache' do
      # cache results in instance variable cache.
      user.can_access_beta?(:dark_mode)

      # should retrieve the beta from instance variable cache.
      expect(user).to receive(:find_or_create_beta_feature_setting).never
      user.can_access_beta?(:dark_mode)
    end
  end

  describe '#validate_beta_name' do
   it 'should raise error' do
     expect { user.send(:validate_beta_name, :beta_doesnt_exist) }.to raise_error(BetaFeature::BetaNotDefined)
     expect { user.send(:validate_beta_name, :beta_doesnt_exist, :invalid_beta) }.to raise_error(BetaFeature::BetaNotDefined)
   end
 end

 describe '#find_or_create_beta_feature_setting' do
   it 'should create a record' do
     expect(user.beta_feature_setting).to be_nil
     user.send(:find_or_create_beta_feature_setting)
     expect(user.beta_feature_setting).not_to be_nil
   end

 end

 describe '#flush_beta_cache' do
  it 'should remove instance variable' do
    user.all_betas
    expect(user.instance_variable_get(:@__all_betas__)).not_to be_nil

    user.send(:flush_beta_cache)
    expect(user.instance_variable_get(:@__all_betas__)).to be_nil
  end

 end
end