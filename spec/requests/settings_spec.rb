require 'rails_helper'

describe 'Setting', type: :request do
  let(:company) { create(:company) }

  describe '#show' do
    it 'should list all beta features of a particular company' do
      betas = [:landing_page_ux_improvement, :dark_mode, :custom_domain]
      company.enable_beta!(*betas)

      get "/beta_feature/#{company.class}/#{company.id}/setting"
      results = JSON.parse(response.body)
      expect(response.code).to eq('200')
      betas.each {|beta| expect(results['betas'].include?(beta))}
    end

    it 'should return 404 when company does not exist' do
      get "/beta_feature/#{company.class}/#{100000000000}/setting"
      expect(response.code).to eq('404')
    end

    it 'should return 422 when class does not exist' do
      get '/beta_feature/InvalidKlass/1/setting'
      expect(response.code).to eq('422')
    end

  end

  describe '#update' do
    it 'should successfully toggle off the betas' do
      params = {
        betas: {
          landing_page_ux_improvement: false,
          dark_mode: false
        }
      }
      put "/beta_feature/#{company.class}/#{company.id}/setting", params: params 

      results = JSON.parse(response.body)
      expect(response.code).to eq("200")
      expect(results['betas'].include?('landing_page_ux_improvement')).to be false
      expect(results['betas'].include?('dark_mode')).to be false
    end

    it 'should successfully toggle on the betas' do
      params = {
        betas: {
          landing_page_ux_improvement: true,
          dark_mode: true
        }
      }
      put "/beta_feature/#{company.class}/#{company.id}/setting", params: params 

      results = JSON.parse(response.body)
      expect(response.code).to eq("200")
      expect(results['betas'].include?('landing_page_ux_improvement')).to be true
      expect(results['betas'].include?('dark_mode')).to be true
    end

    it 'should support true/false of string format' do
      params = {
        betas: {
          landing_page_ux_improvement: "true",
          dark_mode: "false"
        }
      }
      put "/beta_feature/#{company.class}/#{company.id}/setting", params: params 

      results = JSON.parse(response.body)
      expect(response.code).to eq("200")
      expect(results['betas'].include?('landing_page_ux_improvement')).to be true
      expect(results['betas'].include?('dark_mode')).to be false
    end
  end
end
