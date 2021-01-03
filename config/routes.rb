BetaFeature::Engine.routes.draw do
  # list all beta features
  get "all", to: 'configurations#index'

  # list all betas of a particular object
  get ":object_class/:object_id/setting", to: 'settings#show'

  # toggle betas for a particular object
  put ":object_class/:object_id/setting", to: 'settings#update'
end
