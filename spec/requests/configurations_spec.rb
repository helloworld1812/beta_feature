require 'rails_helper'

describe 'Configurations', type: :request do

  describe '#show' do
    it 'should list all beta features' do
      get "/beta_feature/all"
      results = JSON.parse(response.body)
      expect(response.code).to eq('200')
      results = JSON.parse(response.body)
      expect(results.keys.sort).to eq(['custom_domain', 'dark_mode', 'landing_page_ux_improvement'])
    end
  end
end
