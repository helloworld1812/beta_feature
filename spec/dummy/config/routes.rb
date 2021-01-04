Rails.application.routes.draw do
  mount BetaFeature::Engine => "/beta_feature"

  resources :companies
end
